//
//  AddPriceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 25.01.2025.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: AddPriceFeature.self)
struct AddPriceView: View {
    @Bindable var store: StoreOf<AddPriceFeature>
    @FocusState var focus: AddPriceFeature.Field?
    @State private var selectedInt: Int = 1
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Button("Price type: \(store.price.wrappedValue.name)") {
                send(.priceTapped)
            }
            
            priceTextField
            
            Spacer(minLength: 24)
            
            saveButton
        }
        .padding([.horizontal, .bottom], 16)
        .bind($store.focus, to: $focus)
        .sheet(item: $store.scope(state: \.selectPrice, action: \.selectPrice)) { store in
            SelectPriceView(store: store)
                .presentationDetents([.height(200)])
        }
    }
    
    @ViewBuilder
    private var priceTextField: some View {
        switch store.price.wrappedValue {
        case .fixed:
            fixedPriceTextField
            
        case .calculate:
            calculatePriceView
            
        case .doubleCalculate:
            Text("Double")
        }
    }
    
    private var fixedPriceTextField: some View {
        HStack(spacing: 8) {
            PriceTextField(text: $store.priceText)
                .background {
                    GeometryReader { geometry in
                        Color.clear
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .fixedSize()
                .tint(.beanRed)
                .keyboardType(.decimalPad)
                .focused($focus, equals: .price)
            
            Text(store.currency.string)
        }
        .font(.price)
    }
    
    private var calculatePriceView: some View {
        VStack(spacing: 16) {
            fixedPriceTextField
            
            HStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text("Old value")
                        .foregroundStyle(.starDust)
                        .font(.system(size: 16, weight: .semibold))
                    
                    PriceTextField(text: $store.previouslyCounterText)
                        .keyboardType(.numberPad)
                        .focused($focus, equals: .oldCounter)
                        .font(.price)
                        .tint(.beanRed)
                }
                
                VStack(spacing: 8) {
                    Text("New value")
                        .foregroundStyle(.starDust)
                        .font(.system(size: 16, weight: .semibold))
                    
                    PriceTextField(text: $store.currentCounterText)
                        .keyboardType(.numberPad)
                        .focused($focus, equals: .newCounter)
                        .font(.price)
                        .tint(.beanRed)
                }
            }
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            send(.saveButtonTapped)
        }
        .buttonStyle(
            BottomActionButtonStyle(fillColor: .beanRed)
        )
        .disabled(store.isDisableSaveButton)
    }
}

#Preview {
    AddPriceView(
        store: Store(
            initialState: AddPriceFeature.State(
                selectedPrice: Shared(.fixed(value: .zero))
            )
        ) {
            AddPriceFeature()
        }
    )
}
