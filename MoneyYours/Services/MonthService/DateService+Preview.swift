//
//  DateService+Preview.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import Foundation

extension DateService {
    static var previewValue: DateService {
        Self(
            currentMonth: { _, _  in
                return .january
            },
            previousMonthAtCurrent: { _ in
                return .december
            },
            sortedMonthAtCurrent: { _, _ in
                return Month.allCases
            },
            currentYear: { _, _ in
                return 2025
            }
        )
    }
}
