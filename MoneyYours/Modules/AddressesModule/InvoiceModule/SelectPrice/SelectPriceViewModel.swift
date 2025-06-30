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
    
    @Published var isTextFieldFocused: Bool = true
    @Published var oldCounterText: String = "0"
    @Published var newCounterText: String = "0"
    let currency: Currency = .UAH
    
    var isDisableSaveButton: Bool {
        price.wrappedValue.isZero
    }
    
    init(
        coordinator: Coordinator,
        price: Binding<Price>
    ) {
        self.coordinator = coordinator
        self.price = price
        
        coordinator.onDismiss = { sheet in
            switch sheet {
            case .selectPriceType:
                break
                
            default:
                break
            }
        }
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func priceTypeButtonTapped() {
        coordinator.present(sheet: .selectPriceType)
    }
    
    func updatePrice(text: String) {
        switch price.wrappedValue.kind {
        case .fixed:
            let newPrice = Double(text) ?? .zero
            price.wrappedValue = Price(id: UUID(), kind: .fixed, value: newPrice)
            
        case .calculate:
            break
        }
    }
    
    func saveButtonTapped() {
        coordinator.dismiss()
    }
}
