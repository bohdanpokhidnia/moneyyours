//
//  Address.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture
import Foundation

struct Address: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var communalInvoices: IdentifiedArrayOf<CommunalInvoice>
    
    static let preview = Address(
        id: UUID(),
        name: "Preview Address",
        communalInvoices: .preview
    )
}

extension IdentifiedArrayOf where Element == Address {
    static var preview: IdentifiedArrayOf<Address> {
        [
            .preview
        ]
    }
}
