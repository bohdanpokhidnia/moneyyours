//
//  MoneyYoursApp.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct MoneyYoursApp: App {
    static var addressesStore = Store(initialState: AddressesFeature.State()) {
        AddressesFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AddressesView(store: Self.addressesStore)
                .setupNavigationTransparent()
        }
    }
}
