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
        var isEmpty: Bool {
            get {
                archivedAddresses.elements.isEmpty
            }
            set { }
        }
        
        @Shared(.addresses) var addresses: IdentifiedArrayOf<Address> = []
        @Presents var returnAlert: AlertState<ReturnAlert>?
    }
    
    enum Action: BindableAction, ViewAction {
        case view(View)
        case returnAlert(PresentationAction<ReturnAlert>)
        case binding(BindingAction<State>)
        
        enum View {
            case addressButtonTapped(address: Address)
        }
    }
    
    enum ReturnAlert: Equatable {
        case cancel
        case confirm(addressId: Address.ID)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .view(.addressButtonTapped(address)):
                state.returnAlert = .return(address: address)
                return .none
                
            case let .returnAlert(.presented(.confirm(addressId))):
                state.addresses[id: addressId]?.state = .active
                return .none
                
            case .returnAlert:
                return .none
                
            case .binding:
                return .none
            }
        }
        .ifLet(\.$returnAlert, action: \.returnAlert)
    }
}

extension AlertState where Action == ArchivedAddressesFeature.ReturnAlert {
    static func `return`(address: Address) -> AlertState {
        AlertState(
            title: {
                TextState("Do yo want move to return from archive?")
            },
            actions: {
                ButtonState(action: .cancel) {
                    TextState("Cancel")
                }
                
                ButtonState(action: .confirm(addressId: address.id)) {
                    TextState("Confirm")
                }
            },
            message: {
                TextState(address.name)
            }
        )
    }
}
