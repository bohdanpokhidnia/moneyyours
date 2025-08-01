//
//  AddAddressViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SharingGRDB
import SwiftUI

//final class AddAddressViewModel: ObservableObject {
//    @ObservedObject private var coordinator: Coordinator
//    @Published var addressName: String = ""
//    @Dependency(\.defaultDatabase) private var database
//    
//    var isDisableSaveButton: Bool {
//        addressName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
//    }
//    
//    init(coordinator: Coordinator) {
//        self.coordinator = coordinator
//    }
//    
//    func backButtonTapped() {
//        coordinator.dismiss()
//    }
//    
//    func saveButtonTapped() {
//        let address = Address(
//            id: UUID(),
//            name: addressName,
//            state: .active
//        )
//        
//        do {
//            try database.write { db in
//                try Address
//                    .insert { address }
//                    .execute(db)
//            }
//            
//            coordinator.dismiss()
//        } catch {
//            print("[dev] Failed to save address: \(error)")
//        }
//    }
//}

final class NetworkClient {
    func post(addressName: String) async throws -> Address {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        let address = Address(
            id: UUID(),
            name: addressName,
            state: .active
        )
        return address
    }
}

import Combine

final class AddAddressViewModel1: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    @Published var addressName: String = ""
    @Dependency(\.defaultDatabase) private var database
    
    @Published private(set) var isDisableSaveButton: Bool = true
    @Published private(set) var isLoading: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    private var formattedAddressName: String = ""
    
    indirect enum Action: Equatable {
        case dismiss
        case setAddress(name: String)
        case setSaveButton(disabled: Bool)
        case set(loading: Bool)
        case send(name: String, onSuccess: Action, onFailure: Action)
        case showFailureToast(text: String)
    }
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        
        bind()
    }
    
    private func bind() {
        $addressName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.update(name: name.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            .store(in: &cancellables)
    }
    
    func update(name: String) {
        let actions = updateAddress(name: name)
        
        for action in actions {
            perform(action: action)
        }
    }
    
    func updateAddress(name: String) -> [Action] {
        let actions: [Action] = [
            .setAddress(name: name),
            .setSaveButton(disabled: name.isEmpty)
        ]
        return actions
    }
    
    func perform(action: Action) {
        switch action {
        case .dismiss:
            coordinator.dismiss()
            
        case let .setAddress(name):
            formattedAddressName = name
            
        case let .setSaveButton(disabled):
            isDisableSaveButton = disabled
            
        case let .set(loading):
            isLoading = loading
            
        case let .send(name, onSuccess, onFailure):
            Task {
                do {
                    let _ = try await NetworkClient().post(addressName: name)
                    await MainActor.run {
                        perform(action: onSuccess)
                    }
                } catch {
                    await MainActor.run {
                        perform(action: onFailure)
                    }
                }
            }
            
        case let .showFailureToast(text):
            print("[dev] Failure: \(text)")
        }
    }
    
    func backButtonTapped() {
        perform(action: .dismiss)
    }
    
    func saveButtonTapped() {
        let actions = savingAddress(name: formattedAddressName)
        
        for action in actions {
            perform(action: action)
        }
    }
    
    func savingAddress(name: String) -> [Action] {
        let actions: [Action] = [
            .set(loading: true),
            .send(
                name: name,
                onSuccess: .dismiss,
                onFailure: .showFailureToast(text: "Don't save address")
            )
        ]
        return actions
    }
}
