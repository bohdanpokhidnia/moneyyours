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
        var address: Address
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
            case saveButtonTapped
        }
        
        enum Delegate {
            case popToRoot
            case update
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
    
    @Dependency(\.databaseClient) var databaseClient
    
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
                
            case .view(.saveButtonTapped):
                let address = state.address
                return .run { [address = address] send in
                    try databaseClient.addressDatabase.update(address)
                    await send(.delegate(.popToRoot))
                }
                
            case .binding:
                return .none
                
            case .delegate:
                return .none
                
            case .destination(.presented(.removeAlert(.confirm))):
                return .run { [address = state.address] send in
                    try databaseClient.addressDatabase.delete(address)
                    await send(.delegate(.popToRoot))
                }
                
            case .destination(.presented(.archiveAlert(.confirm))):
                state.address.state = .archived
                return .run { [address = state.address] send in
                    try databaseClient.addressDatabase.update(address)
                    await send(.delegate(.popToRoot))
                }
                
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
