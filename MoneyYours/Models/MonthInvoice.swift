//
//  MonthInvoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2024.
//

import Foundation
import ComposableArchitecture

struct MonthInvoice: Identifiable, Equatable {
    let id = UUID()
    let month: Month
    var invoices: IdentifiedArrayOf<Invoice> = []
}

extension MonthInvoice {
    static let mock = Self(
        month: .january,
        invoices: [.mock]
    )
}