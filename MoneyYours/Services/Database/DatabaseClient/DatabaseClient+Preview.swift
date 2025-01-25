//
//  DatabaseClient+Preview.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 14.01.2025.
//

import Foundation

extension DatabaseClient {
    static var previewValue = DatabaseClient(
        addressDatabase: try! AddressDatabase(useInMemoryStore: true)
    )
}
