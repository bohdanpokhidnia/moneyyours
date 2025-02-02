//
//  ArchivedAddressesFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.11.2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ArchivedAddressesFeature {
    @ObservableState
    struct State: Equatable {
        var addresses = IdentifiedArrayOf<Address>()
        @Presents var returnAlert: AlertState<ReturnAlert>?
    }
    
    enum Action: BindableAction, ViewAction {
        case view(View)
        case returnAlert(PresentationAction<ReturnAlert>)
        case binding(BindingAction<State>)
        case delegate(Delegate)
        
        enum View {
            case onAppear
            case backButtonTapped
            case addressButtonTapped(address: Address)
        }
        
        enum Delegate {
            case popToRoot
        }
    }
    
    enum ReturnAlert: Equatable {
        case cancel
        case confirmMove(address: Address)
    }
    
    @Dependency(\.databaseClient) var databaseClient
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce {
            state,
            action in
            switch action {
            case .view(.onAppear):
                do throws(DatabaseError) {
                    let addresses = try databaseClient.addressDatabase.read(
                        predicate: nil,
                        sortDescriptors: SortDescriptor<Address>(\.name)
                    )
                    let archivedAddresses = addresses.filter { $0.state == .archived }
                    state.addresses = IdentifiedArrayOf(uniqueElements: archivedAddresses)
                } catch {
                    print("[dev] \(error.description)")
                }
                return .none
                
            case .view(.backButtonTapped):
                return .run { _ in
                    await dismiss()
                }
            
            case let .view(.addressButtonTapped(address)):
                state.returnAlert = .moveFromArchiveAlert(address: address)
                return .none
                
            case let .returnAlert(.presented(.confirmMove(address))):
                address.state = .active
                
                do throws(DatabaseError) {
                    try databaseClient.addressDatabase.update(address)
                    return .send(.delegate(.popToRoot))
                } catch {
                    print("[dev] \(error.description)")
                    return .none
                }
                
            case .returnAlert:
                return .none
                
            case .binding:
                return .none
                
            case .delegate:
                return .none
            }
        }
        .ifLet(\.$returnAlert, action: \.returnAlert)
    }
}

private extension AlertState where Action == ArchivedAddressesFeature.ReturnAlert {
    static func moveFromArchiveAlert(address: Address) -> AlertState {
        AlertState(
            title: {
                TextState("Do yo want move to return from archive?")
            },
            actions: {
                ButtonState(action: .cancel) {
                    TextState("Cancel")
                }
                
                ButtonState(action: .confirmMove(address: address)) {
                    TextState("Confirm")
                }
            },
            message: {
                TextState(address.name)
            }
        )
    }
}
