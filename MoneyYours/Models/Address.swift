//
//  Address.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import Foundation
import ComposableArchitecture

struct Address: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var invoices: IdentifiedArrayOf<Invoice> = []
}

extension Address {
    static let mock = Address(
        name: "Dev 1",
        invoices: [.mock]
    )
}
