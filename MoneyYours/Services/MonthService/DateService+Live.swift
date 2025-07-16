//
//  DateService+Live.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import SharingGRDB

extension DateService: DependencyKey {
    static var liveValue: DateService {
        DateService(
            currentMonth: { calendar, date throws(DateServiceError) in
                let monthNumber = calendar.component(.month, from: date)
                guard let month = Month(rawValue: monthNumber) else {
                    throw .invalidMonthNumber
                }
                return month
            },
            sortedMonthAtCurrent: { calendar, date throws(DateServiceError) in
                let allMonths = Month.allCases
                let currentMonth = try Self.liveValue.currentMonth(calendar, date)
                guard let startIndex = allMonths.firstIndex(of: currentMonth) else {
                    return allMonths
                }
                let sortedMonths = Array(allMonths[startIndex...]) + Array(allMonths[..<startIndex])
                return sortedMonths
            },
            currentYear: { calendar, date in
                let year = calendar.component(.year, from: date)
                return year
            }
        )
    }
}

extension DependencyValues {
    var dateService: DateService {
        get { self[DateService.self] }
        set { self[DateService.self] = newValue }
    }
}
