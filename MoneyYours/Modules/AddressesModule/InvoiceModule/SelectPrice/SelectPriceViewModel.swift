//
//  SelectPriceViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import Combine
import SwiftUI

final class SelectPriceViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    var price: Binding<Price>
    let communalInvoiceType: CommunalInvoiceType
    
    let currency: Currency = .UAH
    @Published var priceText: String
    @Published var valueText: String = "0"
    @Published var countText: String = "0"
    @Published var secondValueText: String = "0"
    @Published var secondCountText: String = "0"
    @Published var isDisableSaveButton: Bool = true
    
    private var cancellables: Set<AnyCancellable> = []
    private let currencyFormatStyle = UkrainianHryvniaFormatStyle()
    private var isFirstUserEdit: Bool = true
    
    init(
        coordinator: Coordinator,
        price: Binding<Price>,
        communalInvoiceType: CommunalInvoiceType
    ) {
        self.coordinator = coordinator
        self.price = price
        self.communalInvoiceType = communalInvoiceType
        priceText = price.wrappedValue.sumString
        
        bind()
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
            .sink { [weak self] priceText in
                self?.updateFixedPrice(text: priceText)
            }
            .store(in: &cancellables)
        
        $valueText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] valueText in
                self?.updatedCalculatedPrice(value: valueText, count: self?.countText)
            }
            .store(in: &cancellables)
    }
    
    func updateFixedPrice(text: String) {
        let newPrice = Double(text) ?? .zero
        price.wrappedValue = .fixed(id: UUID(), value: newPrice)
        isDisableSaveButton = price.wrappedValue.isZero
        
        print("[dev] prevPrice: \(price.wrappedValue.sum) newPrice: \(newPrice) , isFirstEdit: \(isFirstUserEdit)")
    }
    
    func updatedCalculatedPrice(value: String?, count: String?) {
//        let formattedValue = (value ?? "").replacingOccurrences(of: ",", with: ".")
        let formattedValue = (value ?? "").formatted(.priceInput)
        let sumAtOne = Double(formattedValue) ?? .zero
        let intCount = Int(count ?? "") ?? 0

        price.wrappedValue = .calculate(id: UUID(), value: sumAtOne, count: intCount)
        
        print("[dev] prevPrice: \(price.wrappedValue.sum) sumAtOne: \(sumAtOne)")
    }
//    
//    func updateMultiPrice(
//        value: String,
//        count: String,
//        secondVale: String,
//        secondCount: String
//    ) {
//        let formattedValue = value.replacingOccurrences(of: ",", with: ".")
//        let sumAtOne = Double(formattedValue) ?? .zero
//        let intCount = Int(count) ?? 0
//        
//        let formattedSecondValue = secondVale.replacingOccurrences(of: ",", with: ".")
//        let secondSumAtOne = Double(formattedSecondValue) ?? .zero
//        let secondIntCount = Int(secondCount) ?? 0
//        
//        price.wrappedValue = .multi(
//            id: UUID(),
//            firstValue: sumAtOne,
//            firstCount: intCount,
//            secondValue: secondSumAtOne,
//            secondCount: secondIntCount
//        )
//    }
    
    func priceFrom(text: String) -> Price {
        let doublePrice = Double(text) ?? .zero
        let price = Price.fixed(id: UUID(), value: doublePrice)
        return price
    }
    
    func updatePriceText() {
        priceText = price.wrappedValue.sumString
    }
}
