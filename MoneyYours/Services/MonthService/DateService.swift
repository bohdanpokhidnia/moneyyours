//
//  DateService.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import Dependencies
import Foundation

struct DateService {
    var currentMonth: (Calendar, Date) throws(DateServiceError) -> Month
    var previousMonthAtCurrent: (Month) throws(DateServiceError) -> Month
    var sortedMonthAtCurrent: (Calendar, Date) throws(DateServiceError) -> [Month]
    var currentYear: (Calendar, Date) -> Int
}

extension DependencyValues {
    var dateService: DateService {
        get { self[DateService.self] }
        set { self[DateService.self] = newValue }
    }
}
