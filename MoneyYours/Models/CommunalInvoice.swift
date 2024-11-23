//
//  CommunalInvoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import ComposableArchitecture
import Foundation

struct CommunalInvoice: Identifiable, Equatable, Codable {
    let id: UUID
    let year: Int
    let month: Month
    let type: CommunalInvoiceType
    var price: Double
    var value: Double
    
    static let preview = CommunalInvoice(
        id: UUID(),
        year: 2024,
        month: .january,
        type: .unknown,
        price: 100,
        value: 1000
    )
}

extension IdentifiedArrayOf where Element == CommunalInvoice {
    static var preview: IdentifiedArrayOf<CommunalInvoice> {
        [
            .preview
        ]
    }
}
