//
//  ArchivedAddressesFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.11.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ArchivedAddressesFeature {
    @ObservableState
    struct State: Equatable {
        var archivedAddresses: Shared<IdentifiedArrayOf<Address>> {
            let filteredAddresses = addresses.elements.filter({ $0.state == .archived })
            return Shared(IdentifiedArrayOf(uniqueElements: filteredAddresses))
        }
        
        @Shared(.addresses) var addresses: IdentifiedArrayOf<Address> = []
    }
    
    enum Action {
        case addressButtonTapped(addressId: UUID)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .addressButtonTapped(addressId):
                state.addresses[id: addressId]?.state = .active
                return .none
            }
        }
    }
}
