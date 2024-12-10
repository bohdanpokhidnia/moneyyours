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
        @Shared(.activeAddresses) var activeAddresses
        @Shared(.archivedAddresses) var archivedAddresses
        var path = StackState<Path.State>()
    }
    
    enum Action: ViewAction {
        case view(View)
        case path(StackActionOf<Path>)
        
        enum View {
            case addButtonTapped
            case archiveButtonTapped
        }
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case addAddress(AddAddressFeature)
        case address(AddressFeature)
        case addressSettings(AddressSettingsFeature)
        case archivedAddresses(ArchivedAddressesFeature)
        case monthInvoicesList(MonthInvoicesList)
        case invoiceSelectionList(InvoiceSelectionList)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .view(.addButtonTapped):
                state.path.append(.addAddress(AddAddressFeature.State()))
                return .none
                
            case .view(.archiveButtonTapped):
                state.path.append(.archivedAddresses(ArchivedAddressesFeature.State(addresses: state.$archivedAddresses)))
                return .none
                
            case let .path(.element(id: id, action: .addAddress(.delegate(.save(address))))):
                state.activeAddresses.append(address)
                state.path.pop(from: id)
                return .none
                
            case let .path(.element(id: _, action: .address(.delegate(.settings(address))))):
                state.path.append(.addressSettings(AddressSettingsFeature.State(address: address)))
                return .none
                
            case let .path(.element(id: _, action: .addressSettings(.delegate(.remove(addressId))))):
                state.activeAddresses.remove(id: addressId)
                state.path.removeAll()
                return .none
                
            case let .path(.element(id: _, action: .addressSettings(.delegate(.archive(address))))):
                state.activeAddresses.remove(id: address.id)
                state.archivedAddresses.append(address)
                state.path.removeAll()
                return .none
                
            case let .path(.element(id: _, action: .archivedAddresses(.delegate(.move(address))))):
                state.activeAddresses.append(address)
                state.path.removeAll()
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
