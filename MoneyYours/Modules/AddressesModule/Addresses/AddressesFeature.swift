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
        @Shared(.fileStorage(.addresses)) var addresses: IdentifiedArrayOf<Address> = []
        var contentState: ContentState<Shared<IdentifiedArrayOf<Address>>, TextEmptyStateView.State> = .empty
        var path = StackState<Path.State>()
    }
    
    enum Action: ViewAction {
        case view(View)
        case path(StackActionOf<Path>)
        case updateAddresses
        
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
        case monthInvoicesList(MonthInvoicesList)
        case invoiceSelectionList(InvoiceSelectionList)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .view(.onAppear):
                return .send(.updateAddresses)
                
            case .view(.addButtonTapped):
                state.path.append(.addAddress(AddAddressFeature.State()))
                return .none
                
            case .view(.archiveButtonTapped):
                state.path.append(.archivedAddresses(ArchivedAddressesFeature.State()))
                return .none
                
            case let .path(.element(id: id, action: .addAddress(.delegate(.save(address))))):
                let _ = state.$addresses.withLock { $0.append(address) }
                state.path.pop(from: id)
                return .send(.updateAddresses)
                
            case let .path(.element(id: _, action: .address(.delegate(.settings(address))))):
                state.path.append(.addressSettings(AddressSettingsFeature.State(address: address)))
                return .none
                
            case let .path(.element(id: _, action: .addressSettings(.delegate(.remove(addressId))))):
                let _ = state.$addresses.withLock { $0.remove(id: addressId) }
                state.path.removeAll()
                return .send(.updateAddresses)
                
            case let .path(.element(id: _, action: .addressSettings(.delegate(.archive(addressId))))):
                state.$addresses.withLock({ $0[id: addressId]?.state = .archived })
                state.path.removeAll()
                return .send(.updateAddresses)
                
            case .updateAddresses:
                let filteredAddresses = state.addresses.elements.filter({ $0.state == .active })
                state.contentState = filteredAddresses.isEmpty ? .empty : .content(content: Shared(value: IdentifiedArray(uniqueElements: filteredAddresses)))
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

private extension ContentState where Content == Shared<IdentifiedArrayOf<Address>>, Empty == TextEmptyStateView.State {
    static var empty: ContentState = .empty(
        state: TextEmptyStateView.State(
            title: "Your address list is empty",
            description: "Add a new address to have quick access to important locations."
        )
    )
}
