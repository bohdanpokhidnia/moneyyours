//
//  DateService.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import Foundation

struct DateService {
    var currentMonth: (Calendar, Date) throws(DateServiceError) -> Month
    var sortedMonthAtCurrent: (Calendar, Date) throws(DateServiceError) -> [Month]
    var currentYear: (Calendar, Date) -> Int
}
