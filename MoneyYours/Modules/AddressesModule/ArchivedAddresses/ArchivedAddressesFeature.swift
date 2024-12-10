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
        var addresses: Shared<IdentifiedArrayOf<Address>>
        @Presents var returnAlert: AlertState<ReturnAlert>?
    }
    
    enum Action: BindableAction, ViewAction {
        case view(View)
        case returnAlert(PresentationAction<ReturnAlert>)
        case binding(BindingAction<State>)
        case delegate(Delegate)
        
        enum View {
            case addressButtonTapped(address: Address)
        }
        
        enum Delegate {
            case move(address: Address)
        }
    }
    
    enum ReturnAlert: Equatable {
        case cancel
        case confirmMove(address: Address)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .view(.addressButtonTapped(address)):
                state.returnAlert = .moveFromArchiveAlert(address: address)
                return .none
                
            case let .returnAlert(.presented(.confirmMove(address))):
                state.addresses.wrappedValue.remove(address)
                return .send(.delegate(.move(address: address)))
                
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
