//
//  Currency.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 29.01.2025.
//

import Foundation

enum Currency {
    case UAH
    
    var string: String {
        switch self {
        case .UAH: "₴"
        }
    }
}
