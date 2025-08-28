//
//  Sum.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.08.2025.
//

import Foundation

struct Sum {
    var price: Price

    var sum: Double {
        let firstRowSum = pairSum(value: price.value, count: price.count)
        let secondRowSum = pairSum(value: price.secondValue, count: price.secondCount)
        let sum = firstRowSum + secondRowSum
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
    
    private func pairSum(value: Double?, count: Int?) -> Double {
        (value ?? 0) * Double(count ?? 0)
    }
}
