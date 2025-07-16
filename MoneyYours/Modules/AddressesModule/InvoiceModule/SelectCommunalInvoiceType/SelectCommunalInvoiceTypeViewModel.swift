//
//  SelectCommunalInvoiceTypeViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI

final class SelectCommunalInvoiceTypeViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    var selectedInvoiceType: Binding<CommunalInvoiceType>
    
    let invoiceTypes: [CommunalInvoiceType] = CommunalInvoiceType.allCases
    
    init(
        coordinator: Coordinator,
        selectedInvoiceType: Binding<CommunalInvoiceType>
    ) {
        self.coordinator = coordinator
        self.selectedInvoiceType = selectedInvoiceType
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func select(invoiceType: CommunalInvoiceType) {
        selectedInvoiceType.wrappedValue = invoiceType
        coordinator.dismiss()
    }
}
