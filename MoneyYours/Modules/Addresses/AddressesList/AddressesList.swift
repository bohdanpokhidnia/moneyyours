//
//  AddressesList.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture

@Reducer
struct AddressesList {
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
        case addAddress(AddAddress)
        case addressDetails(AddressDetails)
        case monthInvoicesList(MonthInvoicesList)
    }
    
    @Dependency(\.yearInvoicesLoader) private var yearInvoicesLoader
    
    var body: some ReducerOf<Self> {
        Reduce { (state, action) in
            switch action {
            case .addButtonTapped:
                let yearInvoice = yearInvoicesLoader.fetch(.now)
                let address = Address(name: "", yearInvoices: [yearInvoice])
                state.path.append(.addAddress(AddAddress.State(address: address)))
                return .none
                
            case let .path(.element(id: id, action: .addAddress(.delegate(.save(address))))):
                state.addresses.append(address)
                state.path.pop(from: id)
                return .none

            case let .path(.element(id: _, action: .addressDetails(.delegate(.select(monthInvoice))))):
                state.path.append(
                    .monthInvoicesList(
                        MonthInvoicesList.State(
                            monthInvoice: monthInvoice
                        )
                    )
                )
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension PersistenceReaderKey where Self == PersistenceKeyDefault<FileStorageKey<IdentifiedArrayOf<Address>>> {
    static var addresses: Self {
        PersistenceKeyDefault(
            .fileStorage(.documentsDirectory.appending(component: "addresses.json")),
            []
        )
    }
}
