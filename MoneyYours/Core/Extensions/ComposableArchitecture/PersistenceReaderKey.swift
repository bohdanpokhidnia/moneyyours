//
//  PersistenceReaderKey.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.07.2024.
//

import ComposableArchitecture

extension PersistenceReaderKey where Self == PersistenceKeyDefault<FileStorageKey<IdentifiedArrayOf<Address>>> {
    static var addresses: Self {
        PersistenceKeyDefault(
            .fileStorage(.documentsDirectory.appending(component: "addresses.json")),
            []
        )
    }
}
