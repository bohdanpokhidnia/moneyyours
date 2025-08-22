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
    
    @ObservedObject
    private var coordinator: Coordinator
    
    @FetchOne
    var address: Address?
    
    @FetchAll(animation: .easeIn)
    private var monthInvoices: [MonthInvoice]
    
    @Dependency(\.defaultDatabase)
    private var database
    
    @Published
    var monthInvoiceLists: [MonthInvoiceList] = []
    
    init(
        coordinator: Coordinator,
        addressId: Address.ID,
        monthInvoiceLists: [MonthInvoiceList] = []
    ) {
        self.coordinator = coordinator
        
        if !monthInvoiceLists.isEmpty {
            self.monthInvoiceLists = monthInvoiceLists
        }

        fetchAddress(at: addressId)
        fetchMonths()
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func addMonthButtonTapped() {
        guard let address else {
            return
        }
        coordinator.push(screen: .addMonth(addressId: address.id))
    }
    
    func settingsButtonTapped() {
        guard let address else {
            return
        }
        coordinator.push(screen: .addressSettings(address: address))
    }
    
    func monthButtonTapped(monthInvoice: MonthInvoice) {
        coordinator.push(screen: .month(monthInvoice: monthInvoice))
    }
    
    func deleteMonth(at indexSet: IndexSet) {
        guard let element = indexSet.first else {
            return
        }
        let monthInvoice = monthInvoices[element]
        
        do {
            try database.write { db in
                try MonthInvoice
                    .delete(monthInvoice)
                    .execute(db)
            }
        } catch {
            print("[dev] Failed to delete month invoice: \(error)")
        }
    }
}

private extension AddressViewModel {
    func fetchAddress(at addressId: Address.ID) {
        _address = FetchOne(wrappedValue: address, Address.where { $0.id == addressId })
    }
    
    func fetchMonths() {
        guard let address else {
            return
        }
        
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
