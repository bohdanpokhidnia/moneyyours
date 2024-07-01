//
//  YearInvoicesLoader.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import Foundation
import ComposableArchitecture

struct YearInvoicesLoader {
    var fetch: (Date) -> YearInvoice
}

extension YearInvoicesLoader: DependencyKey {
    static var liveValue = YearInvoicesLoader(
        fetch: { (date) in
            let currentYear = Calendar.current.component(.year, from: date)
            let currentMonthIndex = Calendar.current.component(.month, from: date)
            let months = Month.allCases
                .filter({ $0.rawValue <= currentMonthIndex })
                .sorted(by: { $0.rawValue > $1.rawValue })
            let monthInvoices = IdentifiedArrayOf(uniqueElements: months.map { MonthInvoice(month: $0) })
            let yearInvoice = YearInvoice(year: currentYear, monthInvoices: monthInvoices)
            return yearInvoice
        }
    )
}

extension DependencyValues {
    var yearInvoicesLoader: YearInvoicesLoader {
        get { self[YearInvoicesLoader.self] }
        set { self[YearInvoicesLoader.self] = newValue }
    }
}
