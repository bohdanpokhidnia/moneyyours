//
//  Invoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI

struct Invoice: Identifiable, Equatable {
    var id = UUID()
    let type: InvoiceType
    let price: Double
    var amount: Double
}

extension Invoice: CustomStringConvertible {
    var description: String {
        "\(type.emoji) \(type.name) - price: \(price) amount: \(amount)"
    }
}

extension Invoice {
    static let mock = Invoice(
        type: .unknown,
        price: .zero,
        amount: .zero
    )
}
