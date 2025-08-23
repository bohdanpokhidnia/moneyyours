//
//  Price.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.12.2024.
//

import Foundation
import SharingGRDB

@Table
struct Price: Identifiable, Codable, Equatable, Hashable {
    enum Kind: String, Codable, Equatable, Hashable, CaseIterable, QueryBindable {
        case fixed
        case calculate
        case multi
        
        var name: String {
            switch self {
            case .fixed: "Fixed"
            case .calculate: "Calculate"
            case .multi: "Multi"
            }
        }
        
        var emoji: String {
            switch self {
            case .fixed: "📌"
            case .calculate: "🔢"
            case .multi: "🧮"
            }
        }
    }
    
    var id: UUID
    var kind: Kind
    var value: Double?
    var count: Int?
    var secondValue: Double?
    var secondCount: Int?
    
    init(
        id: UUID,
        kind: Kind,
        value: Double? = nil,
        count: Int? = nil,
        secondValue: Double? = nil,
        secondCount: Int? = nil
    ) {
        self.id = id
        self.kind = kind
        self.value = value
        self.count = count
        self.secondValue = secondValue
        self.secondCount = secondCount
    }
    
    static func fixed(
        id: UUID,
        value: Double
    ) -> Price {
        Price(
            id: id,
            kind: .fixed,
            value: value
        )
    }
    
    static func calculate(
        id: UUID,
        value: Double,
        count: Int
    ) -> Price {
        Price(
            id: id,
            kind: .calculate,
            value: value,
            count: count
        )
    }
    
    static func multi(
        id: UUID,
        firstValue: Double,
        firstCount: Int,
        secondValue: Double,
        secondCount: Int
    ) -> Price {
        Price(
            id: id,
            kind: .multi,
            value: firstValue,
            count: firstCount,
            secondValue: secondValue,
            secondCount: secondCount
        )
    }
    
    private func pairSum(value: Double?, count: Int?) -> Double {
        (value ?? 0) * Double(count ?? 0)
    }
}

// MARK: - Computed Properties
extension Price {
    var sum: Double {
        switch kind {
        case .fixed:
            value ?? 0.0
        case .calculate:
            pairSum(value: value, count: count)
            
        case .multi:
            pairSum(value: value, count: count) + pairSum(value: secondValue, count: secondCount)
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
        let roundedSum = NSDecimalNumber(value: sum).rounding(accordingToBehavior: roundingHandler)
        let sum = String(format: "%.2f", roundedSum.doubleValue)
        return sum
    }

    var isZero: Bool {
        sum == .zero
    }
}
