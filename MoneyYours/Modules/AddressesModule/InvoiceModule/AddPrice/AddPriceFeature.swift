//
//  AddPriceFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import ComposableArchitecture

@Reducer
struct AddPriceFeature {
    @ObservableState
    struct State: Equatable {
        var price: Shared<Price>
        var focus: Field? = .price
        var priceText: String
        var previouslyCounterText: String = "0"
        var currentCounterText: String = "0"
        var currency: Currency = .UAH
        var isDisableSaveButton: Bool = true
        @Presents var selectPrice: SelectPriceFeature.State?
        
        var priceDouble: Double {
            Double(priceText) ?? .zero
        }
        
        var oldCount: Int {
            Int(previouslyCounterText) ?? 0
        }
        
        var newCount: Int {
            Int(currentCounterText) ?? 0
        }
        
        init(selectedPrice: Shared<Price>) {
            self.price = selectedPrice
            priceText = selectedPrice.wrappedValue.sumString
        }
    }
    
    enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case updateSaveButtonState
        case view(View)
        case delegate(Delegate)
        case selectPrice(PresentationAction<SelectPriceFeature.Action>)
        case selectFocus(field: Field)
    }
    
    enum View {
        case priceTapped
        case saveButtonTapped
    }
    
    enum Field {
        case price
        case oldCounter
        case newCounter
    }
    
    enum Delegate {
        case pop
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                switch state.price.wrappedValue {
                case .fixed:
                    state.price.wrappedValue = .fixed(value: state.priceDouble)
                    
                case .calculate:
                    let different = state.newCount - state.oldCount
                    state.price.wrappedValue = different > .zero ? .calculate(value: state.priceDouble, count: different) : state.price.wrappedValue.zero
                    
                case .doubleCalculate:
                    break
                }
                return .send(.updateSaveButtonState)
                
            case .updateSaveButtonState:
                state.isDisableSaveButton = state.price.wrappedValue.sum == .zero
                return .none
                
            case .view(.priceTapped):
                state.selectPrice = SelectPriceFeature.State(selectedPrice: state.price)
                return .none
                
            case .view(.saveButtonTapped):
                return .send(.delegate(.pop))
                
            case .delegate:
                return .none
                
            case .selectPrice(.presented(.select)):
                state.selectPrice = nil
                return .run { send in
                    await send(.selectFocus(field: .price))
                }
                
            case .selectPrice:
                return .none
                
            case let .selectFocus(field):
                state.focus = field
                return .none
            }
        }
        .ifLet(\.$selectPrice, action: \.selectPrice) {
            SelectPriceFeature()
        }
    }
}
