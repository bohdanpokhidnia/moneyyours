//
//  MonthService.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import Foundation

struct MonthService {
    var month: (Calendar, Date) throws(MonthServiceError) -> Month
}
