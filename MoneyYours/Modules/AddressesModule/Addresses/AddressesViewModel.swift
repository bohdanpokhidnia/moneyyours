//
//  AddressesViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.11.2024.
//

import SwiftUI
import SharingGRDB

final class AddressesViewModel: ObservableObject {
    @ObservedObject var coordinator: Coordinator
    @Published var communalInvoiceType: CommunalInvoiceType = .notSelected
    @Published var month: Month = .unknown
    
    @FetchAll(
        Address
            .where { $0.state == AddressState.active }
            .order(by: \.name),
        animation: .easeIn
    )
    var addresses: [Address]
    
    @Dependency(\.defaultDatabase) private var database
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func addAddressButtonTapped() {
        coordinator.push(screen: .addAddress)
    }
    
    func tappedAt(address: Address) {
        coordinator.push(screen: .addressDetails(addressId: address.id))
    }
    
    func deleteAddress(at indexSet: IndexSet) {
        guard let element = indexSet.first else {
            return
        }
        let address = addresses[element]
        
        do {
            try database.write { db in
                try Address
                    .delete(address)
                    .execute(db)
            }
        } catch {
            print("[dev] Failed to delete monthInvoice: \(error)")
        }
    }
}
