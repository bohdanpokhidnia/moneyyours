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
