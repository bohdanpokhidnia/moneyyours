//
//  DateService+Live.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import Dependencies

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
            previousMonthAtCurrent: { month throws(DateServiceError) in
                let currentMonthNumber = month.rawValue
                var previousMonthNumber = currentMonthNumber - 1
                
                if previousMonthNumber < 1 {
                    previousMonthNumber = 12
                }
                
                guard let previousMonth = Month(rawValue: previousMonthNumber) else {
                    throw .invalidMonthNumber
                }
                return previousMonth
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
