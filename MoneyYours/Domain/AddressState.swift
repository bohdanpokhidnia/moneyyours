//
//  AddressState.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 19.01.2025.
//

import Foundation
import SharingGRDB

enum AddressState: String, Codable, QueryBindable {
    case active
    case archived
}
