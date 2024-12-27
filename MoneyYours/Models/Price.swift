//
//  Price.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.12.2024.
//

import Foundation

enum Price: Equatable, Codable, Hashable, CaseIterable {
    case fixed(value: Double)
    case calculate(value: Double, count: Int)
    
    static var allCases: [Price] = [
        .fixed(value: 0),
        .calculate(value: 1, count: 1)
    ]
    
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
}
