//
//  AddressViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SharingGRDB
import SwiftUI

final class AddressViewModel: ObservableObject {
    struct CommunalInvoiceList: Identifiable {
        var id: Int { year }
        let year: Int
        let communalInvoices: [CommunalInvoice]
    }
    
    @ObservedObject private var coordinator: Coordinator
    let address: Address
    
    @FetchAll
    private var communalInvoices: [CommunalInvoice]
    @FetchAll
    private var years: [Int]
    
    @Published private(set) var communalInvoiceLists: [CommunalInvoiceList] = []
    
    init(coordinator: Coordinator, address: Address) {
        self.coordinator = coordinator
        self.address = address
        
        _communalInvoices = FetchAll(
            wrappedValue: communalInvoices,
            CommunalInvoice
                .where{ $0.addressId == address.id }
                .order(by: \.year)
            ,
            animation: .easeInOut
        )
        
        _years = FetchAll(
            wrappedValue: years,
            CommunalInvoice
                .where{ $0.addressId == address.id }
                .select(\.year),
            animation: .easeInOut
        )
        
        let uniqueYears = Set(years)
        
        for year in uniqueYears {
            let invoices = communalInvoices
                .filter({ $0.year == year })
                .sorted(by: { $0.month.rawValue < $1.month.rawValue })
            communalInvoiceLists.append(
                CommunalInvoiceList(
                    year: year,
                    communalInvoices: invoices
                )
            )
        }
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func addInvoiceButtonTapped() {
        coordinator.push(screen: .addInvoice(addressId: address.id))
    }
}
