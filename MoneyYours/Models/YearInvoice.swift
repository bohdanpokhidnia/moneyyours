//
//  YearInvoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2024.
//

import Foundation
import ComposableArchitecture

struct YearInvoice: Identifiable, Equatable, Codable {
    var id = UUID()
    let year: Int
    var monthInvoices: IdentifiedArrayOf<MonthInvoice> = []
}

extension YearInvoice {
    static let mock = Self(
        year: 2024,
        monthInvoices: IdentifiedArray(uniqueElements: Month.allCases.map { MonthInvoice(month: $0, invoices: [.mock]) })
    )
}
