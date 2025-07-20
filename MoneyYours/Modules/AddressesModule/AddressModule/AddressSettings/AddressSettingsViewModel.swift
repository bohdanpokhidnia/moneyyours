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
    
    func addToArchiveButtonTapped() {
        coordinator.present(
            alert: Alert(
                title: "Do yo want move to archive?",
                message: address.name,
                actions: {
                    AlertAction(
                        title: "Confirm",
                        role: .destructive,
                        action: { [weak self] in
                            self?.archivedAddress()
                        }
                    )
                }
            )
        )
    }
    
    func saveButtonTapped() {
        updateAddress()
        coordinator.dismiss()
    }
}

private extension AddressSettingsViewModel {
    func archivedAddress() {
        address.state = .archived
        updateAddress()
        coordinator.dismiss()
    }
    
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
