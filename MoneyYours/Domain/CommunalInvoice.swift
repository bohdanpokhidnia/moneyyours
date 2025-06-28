//
//  CommunalInvoice.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import Foundation
import SharingGRDB

@Table
struct CommunalInvoice: Identifiable, Equatable, Codable {
    let id: UUID
    let addressId: Address.ID
    let year: Int
    let month: Month
    let type: CommunalInvoiceType
    let priceId: Price.ID
}
