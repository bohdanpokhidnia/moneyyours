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
        Address.order(by: \.name),
        animation: .easeIn
    )
    var addresses: [Address]
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func addAddressButtonTapped() {
        coordinator.push(screen: .addAddress)
    }
    
    func tappedAt(address: Address) {
        coordinator.push(screen: .addressDetails(address: address))
    }
}
