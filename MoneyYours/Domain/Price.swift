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
    var id: UUID
    var value: Double?
    var count: Int?
    var secondValue: Double?
    var secondCount: Int?
    
    init(
        id: UUID,
        value: Double? = nil,
        count: Int? = nil,
        secondValue: Double? = nil,
        secondCount: Int? = nil
    ) {
        self.id = id
        self.value = value
        self.count = count
        self.secondValue = secondValue
        self.secondCount = secondCount
    }
    
    static func single(
        id: UUID,
        value: Double
    ) -> Price {
        Price(
            id: id,
            value: value,
            count: 1
        )
    }
    
    static func row(
        id: UUID,
        value: Double,
        count: Int
    ) -> Price {
        Price(
            id: id,
            value: value,
            count: count
        )
    }
    
    private func pairSum(value: Double?, count: Int?) -> Double {
        (value ?? 0) * Double(count ?? 0)
    }
}

// MARK: - Computed Properties

extension Price {
    var sum: Double {
        let sum = pairSum(value: value, count: count) + pairSum(value: secondValue, count: secondCount)
        return sum
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
