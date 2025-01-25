//
//  AddressDatabase.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 14.01.2025.
//

import SwiftData
import Foundation

final class AddressDatabase: SwiftDatabase<Address> {
    init(useInMemoryStore: Bool) throws {
        let configuration = ModelConfiguration(
            for: T.self,
            isStoredInMemoryOnly: useInMemoryStore
        )
        let container = try ModelContainer(for: T.self, configurations: configuration)
        
        super.init(container: container)
    }
}
