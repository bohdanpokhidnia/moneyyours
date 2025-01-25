//
//  Price.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.12.2024.
//

import Foundation

enum Price: Codable, Equatable {
    case fixed(value: Double)
    case calculate(value: Double, count: Int)
    
    var name: String {
        switch self {
        case .fixed: "Fixed"
        case .calculate: "Calculate"
        }
    }
    
    var sum: Double {
        switch self {
            case let .fixed(value): value
            case let .calculate(value, count): value * Double(count)
        }
    }
    
    var text: String {
        let stringSum = String(format: "%.2f", sum)
        return stringSum
    }
}
