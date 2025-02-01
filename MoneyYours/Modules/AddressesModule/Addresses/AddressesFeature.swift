//
//  AddressesFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.11.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AddressesFeature {
    @ObservableState
    struct State {
        var addresses = IdentifiedArrayOf<Address>()
        var path = StackState<Path.State>()
    }
    
    enum Action: ViewAction {
        case view(View)
        case fetchAddresses
        case update(addresses: [Address])
        case path(StackActionOf<Path>)
        
        enum View {
            case onAppear
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
        case addInvoice(AddInvoiceFeature)
        case addPrice(AddPriceFeature)
        case monthInvoicesList(MonthInvoicesList)
        case invoiceSelectionList(InvoiceSelectionList)
    }
    
    @Dependency(\.databaseClient) var databaseClient
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .view(.onAppear):
                return .send(.fetchAddresses)
                
            case .view(.addButtonTapped):
                state.path.append(.addAddress(AddAddressFeature.State()))
                return .none
                
            case .view(.archiveButtonTapped):
                state.path.append(.archivedAddresses(ArchivedAddressesFeature.State()))
                return .none
            
            case .fetchAddresses:
                return .run { send in
                    let addresses = try databaseClient.addressDatabase.read(
                        predicate: nil,
                        sortDescriptors: SortDescriptor<Address>(\.name)
                    )
                    let activeAddresses = addresses.filter({ $0.state == .active })
                    await send(.update(addresses: activeAddresses))
                }
                
            case let .update(addresses):
                state.addresses = IdentifiedArrayOf(uniqueElements: addresses)
                return .none
                
            case let .path(.element(id: id, action: .addAddress(.delegate(.addressSaved)))):
                state.path.pop(from: id)
                return .send(.fetchAddresses)
                
            case let .path(.element(id: _, action: .address(.delegate(.settings(address))))):
                state.path.append(.addressSettings(AddressSettingsFeature.State(address: address)))
                return .none
                
            case .path(.element(id: _, action: .address(.delegate(.addInvoice)))):
                state.path.append(.addInvoice(AddInvoiceFeature.State()))
                return .none
                
            case let .path(.element(id: _, action: .addInvoice(.delegate(.priceButtonTapped(price))))):
                state.path.append(.addPrice(AddPriceFeature.State(price: price)))
                return .none
                
            case let .path(.element(id: id, action: .addPrice(.delegate(.pop)))):
                state.path.pop(from: id)
                return .none
                
            case .path(.element(id: _, action: .addressSettings(.delegate(.popToRoot)))):
                state.path.removeAll()
                return .none
                
            case .path(.element(id: _, action: .addressSettings(.delegate(.update)))):
                state.path.removeAll()
                return .send(.fetchAddresses)
                
            case .path(.element(id: _, action: .archivedAddresses(.delegate(.popToRoot)))):
                state.path.removeAll()
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
