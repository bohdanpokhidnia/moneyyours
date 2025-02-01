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
        var multiPreviouslyCounterText: String = "0"
        var currentCounterText: String = "0"
        var multiCurrentCounterText: String = "0"
        var currency: Currency = .UAH
        var isDisableSaveButton: Bool = true
        @Presents var selectPrice: SelectPriceFeature.State?
        
        var priceDouble: Double {
            Double(priceText) ?? .zero
        }
        
        var previouslyCount: Int {
            Int(previouslyCounterText) ?? 0
        }
        
        var currentCount: Int {
            Int(currentCounterText) ?? 0
        }
        
        var multiPreviouslyCounter: Int {
            Int(multiPreviouslyCounterText) ?? 0
        }
        
        var multiCurrentCounter: Int {
            Int(multiCurrentCounterText) ?? 0
        }
        
        init(price: Shared<Price>) {
            self.price = price
            let afterDotSum = String(price.wrappedValue.sumString.suffix(2))
            
            priceText = if afterDotSum == "00" {
                String(price.wrappedValue.sumString.split(separator: ".").first ?? "0")
            } else {
                price.wrappedValue.sumString
            }
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
                    let different = state.currentCount - state.previouslyCount
                    if different > .zero && state.currentCount > state.previouslyCount {
                        state.price.wrappedValue = .calculate(value: state.priceDouble, count: different)
                    } else {
                        state.price.wrappedValue = .calculate(value: .zero, count: .zero)
                    }
                    
                case .multi:
                    let different = state.currentCount - state.previouslyCount
                    let multiDifferent = state.multiCurrentCounter - state.multiPreviouslyCounter
                    
                    if different > .zero &&
                        multiDifferent > .zero &&
                        state.currentCount > state.previouslyCount &&
                        state.multiCurrentCounter > state.multiPreviouslyCounter
                    {
                        state.price.wrappedValue = .multi(
                            first: .calculate(value: state.priceDouble, count: different),
                            second: .calculate(value: state.priceDouble, count: multiDifferent)
                        )
                    } else {
                        state.price.wrappedValue = .multi(first: .fixed(value: .zero), second: .fixed(value: .zero))
                    }
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
