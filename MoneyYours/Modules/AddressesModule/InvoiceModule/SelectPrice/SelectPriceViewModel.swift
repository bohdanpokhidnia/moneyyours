//
//  SelectPriceViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import SwiftUI

final class SelectPriceViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    var price: Binding<Price>
    let currency: Currency = .UAH
    let currencyFormatStyle = UkrainianHryvniaFormatStyle()
    
    var isDisableSaveButton: Bool {
        price.wrappedValue.isZero
    }
    
    init(
        coordinator: Coordinator,
        price: Binding<Price>
    ) {
        self.coordinator = coordinator
        self.price = price
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func priceTypeButtonTapped() {
        coordinator.present(sheet: .selectPriceType)
    }
    
    func updateFixedPrice(text: String) {
        guard price.wrappedValue.kind == .fixed else {
            return
        }
        let newPrice = Double(text) ?? .zero
        price.wrappedValue = .fixed(id: UUID(), value: newPrice)
    }
    
    func updatedCalculatedPrice(value: String, count: String) {
        let formattedValue = value.replacingOccurrences(of: ",", with: ".")
        let sumAtOne = Double(formattedValue) ?? .zero
        let intCount = Int(count) ?? 0

        price.wrappedValue = .calculate(id: UUID(), value: sumAtOne, count: intCount)
    }
    
    func updateMultiPrice(
        value: String,
        count: String,
        secondVale: String,
        secondCount: String
    ) {
        let formattedValue = value.replacingOccurrences(of: ",", with: ".")
        let sumAtOne = Double(formattedValue) ?? .zero
        let intCount = Int(count) ?? 0
        
        let formattedSecondValue = secondVale.replacingOccurrences(of: ",", with: ".")
        let secondSumAtOne = Double(formattedSecondValue) ?? .zero
        let secondIntCount = Int(secondCount) ?? 0
        
        price.wrappedValue = .multi(
            id: UUID(),
            firstValue: sumAtOne,
            firstCount: intCount,
            secondValue: secondSumAtOne,
            secondCount: secondIntCount
        )
    }
    
    func saveButtonTapped() {
        coordinator.dismiss()
    }
}
