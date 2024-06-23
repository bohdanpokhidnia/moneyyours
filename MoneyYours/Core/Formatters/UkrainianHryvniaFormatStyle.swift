//
//  UkrainianHryvniaFormatStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.06.2024.
//

import Foundation

struct UkrainianHryvniaFormatStyle: FormatStyle {
    typealias FormatInput = Double
    typealias FormatOutput = String

    func format(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₴"
        formatter.currencyDecimalSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}

extension FormatStyle where Self == UkrainianHryvniaFormatStyle {
    static var ukrainianHryvnia: UkrainianHryvniaFormatStyle {
        UkrainianHryvniaFormatStyle()
    }
}
