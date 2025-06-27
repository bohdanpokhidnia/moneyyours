//
//  CommunalInvoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import Foundation

struct CommunalInvoice: Identifiable, Equatable, Codable {
    let id: UUID
    let year: Int
    let month: Month
    let type: CommunalInvoiceType
    let price: Price
    
    static let preview = CommunalInvoice(
        id: UUID(),
        year: 2024,
        month: .january,
        type: .unknown,
        price: .fixed(value: 100)
    )
}

extension Array where Element == CommunalInvoice {
    static var preview: [CommunalInvoice] {
        [
            .preview
        ]
    }
}
