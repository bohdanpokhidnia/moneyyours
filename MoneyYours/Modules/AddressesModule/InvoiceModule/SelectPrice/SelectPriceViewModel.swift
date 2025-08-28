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
    
    @Published var priceText: String = "0"
    @Published var sumText: String = "0"
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
        
        setup()
        bind()
        updateSaveButtonDisabled()
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
    func setup() {
        let sumString = Sum(price: price.wrappedValue).sumString
        priceText = sumString
        sumText = sumString
    }
    
    func bind() {
        $priceText
            .removeDuplicates()
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateMainPrice()
                self?.updateSaveButtonDisabled()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest4($valueText, $countText, $secondValueText, $secondCountText)
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updatePrice()
                self?.updateSaveButtonDisabled()
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
        let value = Double(priceText) ?? .zero
        let count = Int(countText) ?? .zero

        price.update(
            price: Price(
                id: UUID(),
                value: value,
                count: count,
                secondValue: nil,
                secondCount: nil
            )
        )
    
        sumText = Sum(price: price.wrappedValue).sumString
    }
    
    func updatePrice() {
        let value = Double(valueText) ?? .zero
        let count = Int(countText) ?? .zero
        let secondValue = Double(secondValueText) ?? .zero
        let secondCount = Int(secondCountText) ?? .zero

        price.update(
            price: Price(
                id: UUID(),
                value: value,
                count: count,
                secondValue: secondValue,
                secondCount: secondCount
            )
        )

        sumText = Sum(price: price.wrappedValue).sumString
    }
    
    func updateSaveButtonDisabled() {
        let isDisableSaveButton = Sum(price: price.wrappedValue).isZero
        setSaveButton(disabled: isDisableSaveButton)
    }
    
    func setSaveButton(disabled: Bool) {
        isDisableSaveButton = disabled
    }
}
