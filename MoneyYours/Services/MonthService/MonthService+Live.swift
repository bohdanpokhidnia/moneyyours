//
//  MonthService+Live.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import ComposableArchitecture

extension MonthService: DependencyKey {
    static var liveValue: MonthService {
        MonthService(
            month: { calendar, date throws(MonthServiceError) in
                let monthNumber = calendar.component(.month, from: date)
                guard let month = Month(rawValue: monthNumber) else {
                    throw .invalidMonthNumber
                }
                return month
            },
            sortedMonthAtCurrent: { calendar, date throws(MonthServiceError) in
                let allMonths = Month.allCases
                let currentMonth = try Self.liveValue.month(calendar, date)
                guard let startIndex = allMonths.firstIndex(of: currentMonth) else {
                    return allMonths
                }
                let sortedMonths = Array(allMonths[startIndex...]) + Array(allMonths[..<startIndex])
                return sortedMonths
            }
        )
    }
}

extension DependencyValues {
    var monthService: MonthService {
        get { self[MonthService.self] }
        set { self[MonthService.self] = newValue }
    }
}
