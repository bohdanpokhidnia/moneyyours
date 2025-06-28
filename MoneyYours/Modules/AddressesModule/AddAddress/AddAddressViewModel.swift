//
//  AddAddressViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SharingGRDB
import SwiftUI

final class AddAddressViewModel: ObservableObject {
    @Published var addressName: String = ""
    
    @ObservedObject private var coordinator: Coordinator
    @Dependency(\.defaultDatabase) private var database
    
    var isDisableSaveButton: Bool {
        addressName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func saveButtonTapped() {
        let address = Address(
            id: UUID(),
            name: addressName,
            state: .active
        )
        
        do {
            try database.write { db in
                try Address
                    .insert { address }
                    .execute(db)
            }
            
            coordinator.dismiss()
        } catch {
            print("[dev] Failed to save address: \(error)")
        }
    }
}
