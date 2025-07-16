//
//  SelectPriceTypeViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2025.
//

import SwiftUI

final class SelectPriceTypeViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    var priceKind: Binding<Price.Kind>
    
    init(
        coordinator: Coordinator,
        priceKind: Binding<Price.Kind>
    ) {
        self.coordinator = coordinator
        self.priceKind = priceKind
    }
    
    func select(priceKind: Price.Kind) {
        self.priceKind.wrappedValue = priceKind
        coordinator.dismiss()
    }
}
