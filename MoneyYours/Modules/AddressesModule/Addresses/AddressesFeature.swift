//
//  AddressesFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.11.2024.
//

import ComposableArchitecture

@Reducer
struct AddressesFeature {
    @ObservableState
    struct State {
        @Shared(.addresses) var addresses: IdentifiedArrayOf<Address> = []
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case addButtonTapped
        case path(StackActionOf<Path>)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case addAddress(AddAddressFeature)
        case address(AddressFeature)
        case addressSettings(AddressSettingsFeature)
        case monthInvoicesList(MonthInvoicesList)
        case invoiceSelectionList(InvoiceSelectionList)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .addButtonTapped:
                state.path.append(.addAddress(AddAddressFeature.State()))
                return .none
                
            case let .path(.element(id: id, action: .addAddress(.delegate(.save(address))))):
                state.addresses.append(address)
                state.path.pop(from: id)
                return .none
                
            case let .path(.element(id: _, action: .address(.delegate(.settings(address))))):
                state.path.append(.addressSettings(AddressSettingsFeature.State(address: address)))
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
