//
//  Price.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.12.2024.
//

import Foundation

indirect enum Price: Codable, Equatable, Hashable, CaseIterable {
    case fixed(value: Double)
    case calculate(value: Double, count: Int)
    case doubleCalculate(first: Price, second: Price)
    
    var name: String {
        switch self {
        case .fixed: "Fixed"
        case .calculate: "Calculate"
        case .doubleCalculate: "Double calculate"
        }
    }
    
    var sum: Double {
        switch self {
            case let .fixed(value): value
            case let .calculate(value, count): value * Double(count)
            case let .doubleCalculate(first, second): first.sum + second.sum
        }
    }
    
    var sumString: String {
        let stringSum = String(format: "%.2f", sum)
        return stringSum
    }
    
    var isZero: Bool {
        sum == .zero
    }
    
    static var allCases: [Price] = [
        .fixed(value: 0),
        .calculate(
            value: 0,
            count: 0
        ),
        .doubleCalculate(
            first: .calculate(
                value: 0,
                count: 0
            ),
            second: .calculate(
                value: 0,
                count: 0
            )
        )
    ]
    
    var zero: Self {
        switch self {
        case .fixed: .fixed(value: 0)
        case .calculate: .calculate(value: 0, count: 0)
        case .doubleCalculate: .doubleCalculate(first: .calculate(value: 0, count: 0), second: .calculate(value: 0, count: 0))
        }
    }
}
