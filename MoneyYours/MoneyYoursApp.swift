//
//  MoneyYoursApp.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct MoneyYoursApp: App {
    static var addressesStore = Store(initialState: AddressesList.State()) {
        AddressesList()
    }
    
    var body: some Scene {
        WindowGroup {
            AddressesListView(store: Self.addressesStore)
        }
    }
}
