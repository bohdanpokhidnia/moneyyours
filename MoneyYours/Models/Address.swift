//
//  Address.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture
import Foundation
import SwiftData

@Model
class Address: Identifiable, Equatable {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var communalInvoices: IdentifiedArrayOf<CommunalInvoice>
    var state: AddressState
    
    init(
        id: UUID,
        name: String,
        communalInvoices: IdentifiedArrayOf<CommunalInvoice>,
        state: AddressState
    ) {
        self.id = id
        self.name = name
        self.communalInvoices = communalInvoices
        self.state = state
    }
    
    @Transient
    static let preview = Address(
        id: UUID(),
        name: "Preview Address",
        communalInvoices: [.preview],
        state: .active
    )
    
    @Transient
    static let archivedAddress = Address(
        id: UUID(),
        name: "Archived Address",
        communalInvoices: [.preview],
        state: .archived
    )
}

extension IdentifiedArrayOf where Element == Address {
    static var preview: IdentifiedArrayOf<Address> {
        [
            .preview
        ]
    }
}
