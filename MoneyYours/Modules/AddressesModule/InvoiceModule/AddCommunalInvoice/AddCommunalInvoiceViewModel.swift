//
//  AddCommunalInvoiceViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 17.12.2024.
//

import SwiftUI
import SharingGRDB

final class AddCommunalInvoiceViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    
    var name: Binding<String>
    var invoiceType: Binding<CommunalInvoiceType>
    private var monthInvoice: MonthInvoice
    var price: Binding<Price>
    
    var isDisableSaveButton: Bool {
         isFailedName || isFailedInvoiceType || isFailedPrice
    }
    
    private var isFailedName: Bool {
        name.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var isFailedInvoiceType: Bool {
        invoiceType.wrappedValue == .notSelected
    }
    
    private var isFailedPrice: Bool {
        price.wrappedValue.sum == .zero
    }
    
    @Dependency(\.defaultDatabase) private var database
    
    init(
        coordinator: Coordinator,
        monthInvoice: MonthInvoice,
        name: Binding<String>,
        invoiceType: Binding<CommunalInvoiceType>,
        price: Binding<Price>
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
    
    func priceButtonTapped() {
        coordinator.push(screen: .selectPrice)
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
            try save(price: price.wrappedValue, invoice: invoice)
            resetFields()
            coordinator.dismiss()
        } catch {
            print("[dev] Failed to save invoice: \(error)")
        }
    }
}

private extension AddCommunalInvoiceViewModel {
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
        invoiceType.wrappedValue = .notSelected
        price.wrappedValue = .fixed(id: UUID(), value: .zero)
    }
}
