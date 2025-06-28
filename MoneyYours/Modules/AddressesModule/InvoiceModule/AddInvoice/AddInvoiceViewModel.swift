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
    private let addressId: Address.ID
    
    @Published var name: String
    var invoiceType: Binding<CommunalInvoiceType>
    var month: Binding<Month>
    @Published var price: Price
    
    var isDisableSaveButton: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || invoiceType.wrappedValue == .unknown
    }
    
    @Dependency(\.dateService) private var dateService
    @Dependency(\.defaultDatabase) private var database
    
    init(
        coordinator: Coordinator,
        addressId: Address.ID,
        name: String = "Name",
        invoiceType: Binding<CommunalInvoiceType>,
        month: Binding<Month>,
        price: Price = .fixed(id: UUID(), value: .zero)
    ) {
        self.coordinator = coordinator
        self.addressId = addressId
        self.name = name
        self.invoiceType = invoiceType
        self.month = month
        self.price = price
        
        fetchCurrentMonth()
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
    
    func monthButtonTapped() {
        coordinator.push(screen: .selectMonth)
    }
    
    func saveButtonTapped() {
        let year = dateService.currentYear(.current, .now)
        let invoice = CommunalInvoice(
            id: UUID(),
            addressId: addressId,
            year: year,
            month: month.wrappedValue,
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
    func fetchCurrentMonth() {
        guard month.wrappedValue == .unknown else { return }
        do throws(DateServiceError) {
            let currentMonth = try dateService.currentMonth(.current, .now)
            month.wrappedValue = currentMonth
        } catch {
            switch error {
            case .invalidMonthNumber:
                print("[dev] Failed to fetch current month number")
            }
        }
    }
    
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
        invoiceType.wrappedValue = .unknown
        month.wrappedValue = .unknown
    }
}
