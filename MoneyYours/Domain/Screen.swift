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
    case addInvoice(addressId: Address.ID)
    case selectCommunalInvoice
    case selectMonth
}
