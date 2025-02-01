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
    case multi(first: Price, second: Price)
    
    var name: String {
        switch self {
        case .fixed: "Fixed"
        case .calculate: "Calculate"
        case .multi: "Multi"
        }
    }
    
    var sum: Double {
        switch self {
            case let .fixed(value): value
            case let .calculate(value, count): value * Double(count)
            case let .multi(first, second): first.sum + second.sum
        }
    }
    
    var sumString: String {
        let roundingHandler = NSDecimalNumberHandler(
            roundingMode: .plain,
            scale: 2,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        let roundedSum = NSDecimalNumber(value: sum)
            .rounding(accordingToBehavior: roundingHandler)
        let string = String(format: "%.2f", roundedSum.doubleValue)
        return string
    }
    
    var isZero: Bool {
        sum == .zero
    }
    
    var emoji: String {
        switch self {
        case .fixed: "📌"
        case .calculate: "🔢"
        case .multi: "🧮"
        }
    }
    
    static var allCases: [Price] = [
        .fixed(value: .zero),
        .calculate(
            value: .zero,
            count: .zero
        ),
        .multi(
            first: .fixed(value: .zero),
            second: .fixed(value: .zero)
        )
    ]
}
