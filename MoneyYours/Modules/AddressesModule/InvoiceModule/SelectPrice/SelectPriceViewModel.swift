//
//  SelectPriceViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import Combine
import SharingGRDB
import SwiftUI

final class SelectPriceViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    var price: Binding<Price>
    let communalInvoiceType: CommunalInvoiceType
    private let monthInvoice: MonthInvoice
    
    let currency: Currency = .UAH
    let currencyFormatStyle = UkrainianHryvniaFormatStyle()
    @Published var priceText: String
    @Published var valueText: String = "0"
    @Published var countText: String = "1"
    @Published var secondValueText: String = "0"
    @Published var secondCountText: String = "1"
    @Published var isDisableSaveButton: Bool = true
//    @Published var lastCount: Int?
    
    private var cancellables: Set<AnyCancellable> = []
    private var isFirstUserEdit: Bool = true
    @Dependency(\.dateService) private var dateService
    
    @FetchOne private var previousMonthInvoice: MonthInvoice?
    @FetchOne var previousCommunalInvoice: CommunalInvoice?
    @FetchOne var previousPrice: Price?
    
    init(
        coordinator: Coordinator,
        price: Binding<Price>,
        communalInvoiceType: CommunalInvoiceType,
        monthInvoice: MonthInvoice
    ) {
        self.coordinator = coordinator
        self.price = price
        self.communalInvoiceType = communalInvoiceType
        self.monthInvoice = monthInvoice
        priceText = price.wrappedValue.sumString
        
        bind()
//        fetchPreviousMonthInvoice()
    }
    
    func formattedPrice(text: String) -> String {
        let formattedText = text.formatted(.priceInput)
        return formattedText
    }
    
    func beginEditingPriceIfNeeded() {
        guard isFirstUserEdit, priceText != "0" else {
            return
        }
        isFirstUserEdit = false
        priceText = "0"
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func saveButtonTapped() {
        coordinator.dismiss()
    }
}

private extension SelectPriceViewModel {
    func bind() {
        $priceText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateMainPrice()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest4($valueText, $countText, $secondValueText, $secondCountText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updatePrice()
            }
            .store(in: &cancellables)
    }
    
//    func fetchPreviousMonthInvoice() {
//        do throws(DateServiceError) {
//            let previousMonth = try dateService.previousMonthAtCurrent(monthInvoice.month)
//            _previousMonthInvoice = FetchOne(
//                wrappedValue: previousMonthInvoice,
//                MonthInvoice.where({
//                    $0.addressId == monthInvoice.addressId &&
//                    $0.month == previousMonth
//                })
//            )
//            
//            guard let previousMonthInvoice else {
//                print("[dev] prev month: isn't found")
//                return
//            }
//
//            _previousCommunalInvoice = FetchOne(
//                wrappedValue: previousCommunalInvoice,
//                CommunalInvoice.where({
//                    $0.monthInvoiceId == previousMonthInvoice.id &&
//                    $0.type == communalInvoiceType
//                })
//            )
//            
//            guard let previousCommunalInvoice else {
//                print("[dev] prev communal isn't found")
//                return
//            }
//            
//            _previousPrice = FetchOne(wrappedValue: previousPrice, Price.where({ $0.id == previousCommunalInvoice.priceId }))
//            
//            guard let previousPrice else {
//                print("[dev] prev price isn't found")
//                return
//            }
//            
//            print("[dev] \(previousPrice)")
//            
//        } catch {
//            print("[dev] Failed found previous month: \(error)")
//        }
//    }
    
    func updateMainPrice() {
        let newPrice = Double(priceText) ?? .zero
        let count = Int(countText) ?? 0
        let secondValue = Double(secondValueText) ?? .zero
        let secondCount = Int(secondCountText) ?? 0
        
//        price.wrappedValue = .single(id: UUID(), value: newPrice)
        
        price.wrappedValue = Price(
            id: UUID(),
            value: newPrice,
            count: count,
            secondValue: secondValue,
            secondCount: secondCount
        )
        
        let isDisableSaveButton = price.wrappedValue.isZero
        setSaveButton(disabled: isDisableSaveButton)
    }
    
    func updatePrice() {
        let value = Double(valueText) ?? .zero
        let count = price.wrappedValue.count ?? 0
        let secondValue = price.wrappedValue.secondValue ?? .zero
        let secondCount = price.wrappedValue.secondCount ?? 0
        
        price.wrappedValue = Price(
            id: UUID(),
            value: value,
            count: count,
            secondValue: secondValue,
            secondCount: secondCount
        )
        
        let isDisableSaveButton = price.wrappedValue.isZero
        setSaveButton(disabled: isDisableSaveButton)
        priceText = price.wrappedValue.sumString
        
        print("[dev] price: \(price)")
    }
    
    func setSaveButton(disabled: Bool) {
        isDisableSaveButton = disabled
    }
}
