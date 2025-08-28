//
//  MonthViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.06.2025.
//

import SwiftUI
import SharingGRDB

final class MonthViewModel: ObservableObject {
    @ObservedObject var coordinator: Coordinator
    let monthInvoice: MonthInvoice
    
    @FetchAll private var communalInvoices: [CommunalInvoice]
    @FetchAll private var prices: [Price]
    @Published private(set) var communalInvoiceLists: [CommunalInvoiceList] = []
    @Dependency(\.defaultDatabase) private var database
    
    init(
        coordinator: Coordinator,
        monthInvoice: MonthInvoice
    ) {
        self.coordinator = coordinator
        self.monthInvoice = monthInvoice
        
        fetchInvoices()
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func addInvoiceButtonTapped() {
        coordinator.push(screen: .addInvoice(monthInvoice: monthInvoice))
    }
    
    func summaryButtonTapped() {
        coordinator.push(screen: .summary(communalInvoiceLists: communalInvoiceLists))
    }
    
    func deleteMonthInvoice(at indexSet: IndexSet) {
        guard let element = indexSet.first else {
            return
        }
        let list = communalInvoiceLists[element]
        let invoice = list.invoice
        
        do {
            try database.write { db in
                try CommunalInvoice
                    .delete(invoice)
                    .execute(db)
            }
        } catch {
            print("[dev] Failed to delete monthInvoice: \(error)")
        }
    }
}

private extension MonthViewModel {
    func fetchInvoices() {
        _communalInvoices = FetchAll(
            wrappedValue: communalInvoices,
            CommunalInvoice
                .where { $0.addressId == monthInvoice.addressId }
                .where { $0.year == monthInvoice.year }
                .where { $0.monthInvoiceId == monthInvoice.id }
                .order(by: \.type)
            ,
            animation: .easeInOut
        )
        
        for invoice in communalInvoices {
            guard let price = prices.first(where: { $0.id == invoice.priceId }) else {
                continue
            }
            let sum = Sum(price: price).sum
            let title = [invoice.name, ", Price:", sum.formatted(.ua)].joined(separator: " ")
            
            let list = CommunalInvoiceList(
                title: title,
                invoice: invoice,
                price: sum
            )
            communalInvoiceLists.append(list)
        }
    }
}
