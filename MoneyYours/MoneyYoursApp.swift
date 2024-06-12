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
    static var addressesStore = Store(initialState: AddressesFeature.State()) {
        AddressesFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AddressesView(store: Self.addressesStore)
                .onAppear {
                    let image = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal).withTintColor(.tintColor)
                    
                    UINavigationBar.appearance().backIndicatorImage = image
                    UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
                }
        }
    }
}
