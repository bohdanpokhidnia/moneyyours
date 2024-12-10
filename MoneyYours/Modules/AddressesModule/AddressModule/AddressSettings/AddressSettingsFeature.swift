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
        @Shared var address: Address
        @Presents var destination: Destination.State?
    }
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
        case delegate(Delegate)
        case destination(PresentationAction<Destination.Action>)
        
        enum View {
            case removeButtonTapped
            case addToArchiveButtonTapped
        }
        
        enum Delegate {
            case archive(address: Address)
            case remove(addressId: Address.ID)
        }
    }
    
    enum RemoveAlert {
        case cancel
        case confirm
    }
    
    enum ArchiveAlert {
        case cancel
        case confirm
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case removeAlert(AlertState<RemoveAlert>)
        case archiveAlert(AlertState<ArchiveAlert>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.address):
                state.address.name = state.address.name.trimmingCharacters(in: .whitespaces)
                return .none
                
            case .view(.removeButtonTapped):
                let addressName = state.address.name
                state.destination = .removeAlert(.remove(addressName: addressName))
                return .none
                
            case .view(.addToArchiveButtonTapped):
                let addressName = state.address.name
                state.destination = .archiveAlert(.archive(addressName: addressName))
                return .none
                
            case .binding:
                return .none
                
            case .delegate:
                return .none
                
            case .destination(.presented(.removeAlert(.confirm))):
                return .send(.delegate(.remove(addressId: state.address.id)))
                
            case .destination(.presented(.archiveAlert(.confirm))):
                return .send(.delegate(.archive(address: state.address)))
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
