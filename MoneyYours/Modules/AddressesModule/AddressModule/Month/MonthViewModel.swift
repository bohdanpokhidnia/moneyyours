//
//  MonthViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.06.2025.
//

import SwiftUI
import SharingGRDB

final class MonthViewModel: ObservableObject {
    struct CommunalInvoiceList: Identifiable {
        var id: UUID { invoice.id }
        
        let title: String
        let invoice: CommunalInvoice
        let price: Double
    }
    
    @ObservedObject var coordinator: Coordinator
    let monthInvoice: MonthInvoice
    
    @FetchAll
    private var communalInvoices: [CommunalInvoice]
    
    @FetchAll
    private var prices: [Price]
    
    @Published private(set) var communalInvoiceLists: [CommunalInvoiceList] = []
    
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
}

private extension MonthViewModel {
    func fetchInvoices() {
        _communalInvoices = FetchAll(
            wrappedValue: communalInvoices,
            CommunalInvoice
                .where { $0.addressId == monthInvoice.addressId }
                .where { $0.year == monthInvoice.year }
                .order(by: \.type)
            ,
            animation: .easeInOut
        )
        
        for invoice in communalInvoices {
            guard let price = prices.first(where: { $0.id == invoice.priceId }) else {
                continue
            }
            let sum = price.sum
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
