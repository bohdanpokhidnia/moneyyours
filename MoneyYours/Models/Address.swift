//
//  Address.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import Foundation
import ComposableArchitecture

struct Address: Identifiable, Codable {
    var id = UUID()
    var name: String
    var yearInvoices: IdentifiedArrayOf<YearInvoice>
}

// MARK: - Equatable

extension Address: Equatable {
    static func == (lhs: Address, rhs: Address) -> Bool {
        lhs.id == rhs.id
    }
}

extension Address {
    static let mock = Self(
        name: "Dev 1",
        yearInvoices: [YearInvoice(year: 2024, monthInvoices: [MonthInvoice(month: .july, invoices: [])])]
    )
    
    static let mock1 = Self(
        name: "Dev 2",
        yearInvoices: [.mock]
    )
    
    static let mock2 = Self(
        name: "Dev 3",
        yearInvoices: [.mock]
    )
    
    static let mock3 = Self(
        name: "Dev 4",
        yearInvoices: [.mock]
    )
    
    static let mock4 = Self(
        name: "Dev 5",
        yearInvoices: [.mock]
    )
}
