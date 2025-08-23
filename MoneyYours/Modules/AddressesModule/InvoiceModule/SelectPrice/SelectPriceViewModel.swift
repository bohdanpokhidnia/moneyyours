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
    @Published var countText: String = "1"
    @Published var secondValueText: String = "0"
    @Published var secondCountText: String = "1"
    @Published var isDisableSaveButton: Bool = true
    
    private var cancellables: Set<AnyCancellable> = []
    /*private */let currencyFormatStyle = UkrainianHryvniaFormatStyle()
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
            .sink { [weak self] _ in
                self?.updateSinglePrice()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest4($valueText, $countText, $secondValueText, $secondCountText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updatePrice()
            }
            .store(in: &cancellables)
    }
    
    func updateSinglePrice() {
        let newPrice = Double(priceText) ?? .zero
        price.wrappedValue = .single(id: UUID(), value: newPrice)
        
        let isDisableSaveButton = price.wrappedValue.isZero
        setSaveButton(disabled: isDisableSaveButton)
    }
    
    func updatePrice() {
        let value = Double(valueText) ?? .zero
        let count = Int(countText) ?? 0
        let secondValue = Double(secondValueText) ?? .zero
        let secondCount = Int(secondCountText) ?? 0
        
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
    }
    
    func setSaveButton(disabled: Bool) {
        isDisableSaveButton = disabled
    }
}
