//
//  CommunalInvoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI

struct CommunalInvoice: Identifiable, Equatable, Codable {
    var id = UUID()
    let type: InvoiceType
    var price: Double
    var amount: Double
    var pastValue: Double = .zero
    var nowValue: Double = .zero
}

extension CommunalInvoice: CustomStringConvertible {
    var description: String {
        "\(type.emoji) \(type.name) - price: \(price) amount: \(amount)"
    }
}

extension CommunalInvoice {
    static let mock = CommunalInvoice(
        type: .unknown,
        price: .zero,
        amount: .zero
    )
}
