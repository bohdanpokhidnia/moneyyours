//
//  AddressViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SharingGRDB
import SwiftUI

final class AddressViewModel: ObservableObject {
    struct MonthInvoiceList: Identifiable {
        var id: Int { year }
        let year: Int
        let monthInvoices: [MonthInvoice]
    }
    
    @ObservedObject private var coordinator: Coordinator
    let address: Address
    
    @FetchAll
    private var monthInvoices: [MonthInvoice]
    
    @Published private(set) var monthInvoiceLists: [MonthInvoiceList] = []
    
    init(coordinator: Coordinator, address: Address) {
        self.coordinator = coordinator
        self.address = address

        fetchMonths()
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func addMonthButtonTapped() {
        coordinator.push(screen: .addMonth(addressId: address.id))
    }
    
    func monthButtonTapped(monthInvoice: MonthInvoice) {
        coordinator.push(screen: .month(monthInvoice: monthInvoice))
    }
}

private extension AddressViewModel {
    func fetchMonths() {
        let invoicesForAddress = monthInvoices
            .filter { $0.addressId == address.id }
            .sorted { $0.year < $1.year }

        let groupedByYear = Dictionary(grouping: invoicesForAddress, by: \.year)
        
        monthInvoiceLists = groupedByYear
            .map { year, invoices in
                let uniqueInvoicesByMonth = Dictionary(grouping: invoices, by: \.month)
                    .compactMap { $0.value.first }
                    .sorted(by: { $0.month.rawValue > $1.month.rawValue })
                
                return MonthInvoiceList(
                    year: year,
                    monthInvoices: uniqueInvoicesByMonth
                )
            }
    }
}
