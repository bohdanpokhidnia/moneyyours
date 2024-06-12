//
//  AddressesFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture

@Reducer
struct AddressesFeature {
    @ObservableState
    struct State: Equatable {
        var addresses: IdentifiedArrayOf<Address> = []
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case addAddress(AddAddressFeature)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case let .path(.element(id: id, action: .addAddress(.delegate(.save(address))))):
                state.addresses.append(address)
                state.path.pop(from: id)
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
