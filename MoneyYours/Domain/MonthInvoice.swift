//
//  MonthInvoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 29.06.2025.
//

import Foundation
import SharingGRDB

@Table
struct MonthInvoice: Identifiable, Hashable {
    var id: UUID
    var addressId: Address.ID
    var year: Int
    var month: Month
    
    static let preview = MonthInvoice(
        id: UUID(),
        addressId: UUID(),
        year: 2025,
        month: .june
    )
}
