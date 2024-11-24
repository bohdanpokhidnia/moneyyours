//
//  AddressFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AddressFeature {
    @ObservableState
    struct State: Equatable {
        @Shared var address: Address
        
        var yeas: [Int] {
            Set<Int>(address.communalInvoices.map { $0.year }).map({ $0 })
        }
    }
    
    enum Action {
        case settingsButtonTapped
        case delegate(Delegate)
        
        @CasePathable
        enum Delegate {
            case settings(address: Shared<Address>)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .settingsButtonTapped:
                return .send(.delegate(.settings(address: state.$address)))
                
            case .delegate:
                return .none
            }
        }
    }
}
