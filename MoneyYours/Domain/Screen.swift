//
//  Screen.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2025.
//

import SwiftUI

enum Screen: Hashable {
    case addAddress
    case addressDetails(addressId: Address.ID)
    case addInvoice(monthInvoice: MonthInvoice)
    case addressSettings(address: Address)
    case selectCommunalInvoice
    case selectPrice
    case addMonth(addressId: Address.ID)
    case month(monthInvoice: MonthInvoice)
    case summary(communalInvoiceLists: [CommunalInvoiceList])
}
