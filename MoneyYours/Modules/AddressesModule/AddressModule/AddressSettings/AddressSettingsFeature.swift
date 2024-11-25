//
//  AddressSettingsFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.11.2024.
//

import ComposableArchitecture

@Reducer
struct AddressSettingsFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var removeAlert: AlertState<RemoveAlert>?
        @Shared var address: Address
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case removeButtonTapped
        case delegate(Delegate)
        case removeAlert(PresentationAction<RemoveAlert>)
    }
    
    enum Delegate {
        case remove(address: Address)
    }
    
    enum RemoveAlert {
        case cancel
        case confirm
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.address):
                state.address.name = state.address.name.trimmingCharacters(in: .whitespaces)
                return .none
                
            case .removeButtonTapped:
                let addressName = state.address.name
                state.removeAlert = AlertState(
                    title: {
                        TextState("Do yo want remove?")
                    },
                    actions: {
                        ButtonState(role: .cancel, action: .cancel) {
                            TextState("Cancel")
                        }
                        
                        ButtonState(role: .destructive, action: .confirm) {
                            TextState("Confirm")
                        }
                    },
                    message: {
                        TextState(addressName)
                    }
                )
                return .none
                
            case .binding:
                return .none
                
            case .delegate:
                return .none
                
            case .removeAlert(.presented(.confirm)):
                return .send(.delegate(.remove(address: state.address)))
                
            case .removeAlert:
                return .none
            }
        }
        .ifLet(\.$removeAlert, action: \.removeAlert)
    }
}
