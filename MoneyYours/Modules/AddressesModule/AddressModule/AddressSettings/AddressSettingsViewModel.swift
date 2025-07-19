//
//  AddressSettingsViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.11.2024.
//

import SwiftUI
import SharingGRDB

final class AddressSettingsViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    @Dependency(\.defaultDatabase) private var database
    
    @Published var address: Address
    
    init(coordinator: Coordinator, address: Address) {
        self.coordinator = coordinator
        self.address = address
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func saveButtonTapped() {
        print("[dev] \(address)")
        updateAddress()
        coordinator.dismiss()
    }
}

private extension AddressSettingsViewModel {
    func updateAddress() {
        do {
            try database.write { db in
                try Address
                    .update(address)
                    .execute(db)
            }
        } catch {
            print("[dev] Failed to update address: \(error)")
        }
    }
}
