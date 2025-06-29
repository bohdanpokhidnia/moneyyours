//
//  Screen.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2025.
//

import SwiftUI

enum Screen: Hashable {
    case addAddress
    case addressDetails(address: Address)
    case addInvoice(monthInvoice: MonthInvoice)
    case selectCommunalInvoice
    case addMonth(addressId: Address.ID)
    case month(monthInvoice: MonthInvoice)
}
