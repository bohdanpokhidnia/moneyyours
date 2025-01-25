//
//  DatabaseClient+Live.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 14.01.2025.
//

import ComposableArchitecture

extension DatabaseClient: DependencyKey {
    static var liveValue = DatabaseClient(
        addressDatabase: try! AddressDatabase(useInMemoryStore: false)
    )
}

extension DependencyValues {
    var databaseClient: DatabaseClient {
        get { self[DatabaseClient.self] }
        set { self[DatabaseClient.self] = newValue }
    }
}
