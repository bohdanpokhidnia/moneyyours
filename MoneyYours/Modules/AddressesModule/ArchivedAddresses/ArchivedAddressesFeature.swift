//
//  ArchivedAddressesFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.11.2024.
//

import ComposableArchitecture

@Reducer
struct ArchivedAddressesFeature {
    @ObservableState
    struct State: Equatable {
        @Shared(.fileStorage(.addresses)) var addresses: IdentifiedArrayOf<Address> = []
        var contentState: ContentState<Shared<IdentifiedArrayOf<Address>>, TextEmptyStateView.State> = .empty
        @Presents var returnAlert: AlertState<ReturnAlert>?
    }
    
    enum Action: BindableAction, ViewAction {
        case view(View)
        case returnAlert(PresentationAction<ReturnAlert>)
        case binding(BindingAction<State>)
        case updateAddresses
        
        enum View {
            case onAppear
            case addressButtonTapped(address: Address)
        }
    }
    
    enum ReturnAlert: Equatable {
        case cancel
        case confirmMove(addressId: Address.ID)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.onAppear):
                return .send(.updateAddresses)
                
            case let .view(.addressButtonTapped(address)):
                state.returnAlert = .moveFromArchiveAlert(address: address)
                return .none
                
            case let .returnAlert(.presented(.confirmMove(addressId))):
                state.$addresses.withLock { $0[id: addressId]?.state = .active }
                return .send(.updateAddresses)
                
            case .updateAddresses:
                let filteredAddresses = state.addresses.elements.filter({ $0.state == .archived })
                state.contentState = filteredAddresses.isEmpty ? .empty : .content(content: Shared(value: IdentifiedArray(uniqueElements: filteredAddresses)))
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

private extension ContentState where Content == Shared<IdentifiedArrayOf<Address>>, Empty == TextEmptyStateView.State {
    static var empty: ContentState = .empty(
        state: TextEmptyStateView.State(
            title: "No Archived Addresses Yet",
            description: "It looks like you haven’t archived any addresses."
        )
    )
}

private extension AlertState where Action == ArchivedAddressesFeature.ReturnAlert {
    static func moveFromArchiveAlert(address: Address) -> AlertState {
        AlertState(
            title: {
                TextState("Do yo want move to return from archive?")
            },
            actions: {
                ButtonState(action: .cancel) {
                    TextState("Cancel")
                }
                
                ButtonState(action: .confirmMove(addressId: address.id)) {
                    TextState("Confirm")
                }
            },
            message: {
                TextState(address.name)
            }
        )
    }
}
