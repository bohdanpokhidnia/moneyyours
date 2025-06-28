//
//  AddressViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SharingGRDB
import SwiftUI

final class AddressViewModel: ObservableObject {
    struct MonthList: Identifiable {
        var id: Int { year }
        let year: Int
        let months: [Month]
    }
    
    @ObservedObject private var coordinator: Coordinator
    let address: Address
    
    @FetchAll
    private var communalInvoices: [CommunalInvoice]
    @FetchAll
    private var years: [Int]
    
    @Published private(set) var monthLists: [MonthList] = []
    
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
            let months = communalInvoices
                .filter({ $0.year == year })
                .map(\.month)
            
            let uniqueMonths = Set(months)
                .map { $0 }
                .sorted(by: { $0.rawValue < $1.rawValue })
            
            monthLists.append(MonthList(year: year, months: uniqueMonths))
        }
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func addInvoiceButtonTapped() {
        coordinator.push(screen: .addInvoice(addressId: address.id))
    }
}
