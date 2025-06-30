//
//  AddInvoiceViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 17.12.2024.
//

import SwiftUI
import SharingGRDB

final class AddInvoiceViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    
    var name: Binding<String>
    var invoiceType: Binding<CommunalInvoiceType>
    private var monthInvoice: MonthInvoice
    @Published var price: Price
    
    var isDisableSaveButton: Bool {
         isFailedName || isFailedInvoiceType || isFailedPrice
    }
    
    private var isFailedName: Bool {
        name.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var isFailedInvoiceType: Bool {
        invoiceType.wrappedValue == .unknown
    }
    
    private var isFailedPrice: Bool {
        price.sum == .zero
    }
    
    @Dependency(\.defaultDatabase) private var database
    
    init(
        coordinator: Coordinator,
        monthInvoice: MonthInvoice,
        name: Binding<String>,
        invoiceType: Binding<CommunalInvoiceType>,
        price: Price = .fixed(id: UUID(), value: .zero)
    ) {
        self.coordinator = coordinator
        self.monthInvoice = monthInvoice
        self.name = name
        self.invoiceType = invoiceType
        self.price = price
    }
    
    func onDisappear() {
        resetFields()
    }
    
    func backButtonTapped() {
        resetFields()
        coordinator.dismiss()
    }
    
    func invoiceTypeButtonTapped() {
        coordinator.push(screen: .selectCommunalInvoice)
    }
    
    func saveButtonTapped() {
        let invoice = CommunalInvoice(
            id: UUID(),
            addressId: monthInvoice.addressId,
            year: monthInvoice.year,
            name: name.wrappedValue,
            monthInvoiceId: monthInvoice.id,
            type: invoiceType.wrappedValue,
            priceId: price.id
        )
        
        do {
            try save(price: price, invoice: invoice)
            resetFields()
            coordinator.dismiss()
        } catch {
            print("[dev] Failed to save invoice: \(error)")
        }
    }
}

private extension AddInvoiceViewModel {
    func save(price: Price, invoice: CommunalInvoice) throws {
        try database.write { db in
            try Price
                .insert { price }
                .execute(db)
            
            try CommunalInvoice
                .insert { invoice }
                .execute(db)
        }
    }
    
    func resetFields() {
        name.wrappedValue = "Name"
        invoiceType.wrappedValue = .unknown
    }
}
