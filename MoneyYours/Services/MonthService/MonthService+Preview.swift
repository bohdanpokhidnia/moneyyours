//
//  MonthService+Preview.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 18.12.2024.
//

import Foundation

extension MonthService {
    static var previewValue: MonthService {
        Self(
            month: { _, _  in
                return .january
            }
        )
    }
}
