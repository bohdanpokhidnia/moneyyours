//
//  Address.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import Foundation
import SharingGRDB

@Table
struct Address: Identifiable, Hashable, Equatable {
    var id: UUID
    var name: String
    var state: AddressState
    
    static let activeAddress = Address(
        id: UUID(),
        name: "Active Address",
        state: .active
    )
    
    static let archivedAddress = Address(
        id: UUID(),
        name: "Archived Address",
        state: .archived
    )
}

//extension Array where Element == Address {
//    static var preview: [Address] {
//        [
//            .preview
//        ]
//    }
//}
