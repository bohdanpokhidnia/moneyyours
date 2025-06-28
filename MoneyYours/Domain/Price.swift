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
    enum Kind: String, Codable, Equatable, Hashable, QueryBindable {
        case fixed
        case calculate
    }
    
    var id: UUID
    var kind: Kind
    var value: Double?
    var count: Int?
    
    init(
        id: UUID,
        kind: Kind,
        value: Double? = nil,
        count: Int? = nil
    ) {
        self.id = id
        self.kind = kind
        self.value = value
        self.count = count
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
}

// MARK: - Computed Properties
extension Price {
    var name: String {
        switch kind {
        case .fixed: "Fixed"
        case .calculate: "Calculate"
//        case .multi: "Multi"
        }
    }

    var sum: Double {
        switch kind {
        case .fixed:
            value ?? 0.0
        case .calculate:
            (value ?? 0.0) * Double(count ?? 0)
//        case let .multi(first, second):
//            first.sum + second.sum
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

    var emoji: String {
        switch kind {
        case .fixed: "📌"
        case .calculate: "🔢"
//        case .multi: "🧮"
        }
    }
}
