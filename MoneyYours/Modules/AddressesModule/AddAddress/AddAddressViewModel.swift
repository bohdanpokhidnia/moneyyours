//
//  AddAddressViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SharingGRDB
import SwiftUI

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

//final class AddAddressViewModel: ObservableObject {
//    @ObservedObject private var coordinator: Coordinator
//    @Published var addressName: String = ""
//    @Dependency(\.defaultDatabase) private var database
//    
//    var isDisableSaveButton: Bool {
//        addressName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
//    }
//    
//    @Published private(set) var isLoading: Bool = false
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
//        isLoading = true
//        
//        Task {
//            do {
//                let address = try await NetworkClient().post(addressName: addressName)
//                print("Fetched Address: \(address)")
//                await MainActor.run {
//                    isLoading = false
//                    backButtonTapped()
//                }
//            } catch {
//                print("Failed send address: \(error)")
//                await MainActor.run {
//                    isLoading = false
//                    showFailureToast(text: error.localizedDescription)
//                }
//            }
//        }
//    }
//    
//    private func showFailureToast(text: String) {
//        print("[dev] Failure: \(text)")
//    }
//}

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
    
    func updateAddress(name: String) -> [Action] {
        let actions: [Action] = [
            .setAddress(name: name),
            .setSaveButton(disabled: name.isEmpty)
        ]
        return actions
    }
    
    func update(name: String) {
        let actions = updateAddress(name: name)
        
        for action in actions {
            perform(action: action)
        }
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
                    let address = try await NetworkClient().post(addressName: name)
                    await MainActor.run {
//                        perform(action: onSuccess)
                        parse(address: address)
                    }
                } catch {
                    await MainActor.run {
                        perform(action: onFailure)
                    }
                }
            }
            
        case let .showFailureToast(text):
            showFailureToast(text: text)
        }
    }
    
    func parse(address: Address) {
//        let actions = savingAddress(name: formattedAddressName)
//
        if isLoading {
            if isDisableSaveButton {
                ///
            } else {
                ///
            }
        }
        
//        for action in actions {
//            perform(action: action)
//        }
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
    
    private func showFailureToast(text: String) {
        print("[dev] Failure: \(text)")
    }
}
