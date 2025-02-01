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
}

private extension AddPriceView {
    @ViewBuilder
    private var priceTextField: some View {
        switch store.price.wrappedValue {
        case .fixed:
            simplePriceTextField
            
        case .calculate:
            calculatePriceView
            
        case .doubleCalculate:
            Text("Double")
        }
    }
    
    private var simplePriceTextField: some View {
        VStack(spacing: 8) {
            Text("Sum")
                .foregroundStyle(.slateGrey)
                .font(.footnote)
            
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
    }
    
    private var calculatePriceView: some View {
        VStack(spacing: 32) {
            simplePriceTextField
            
            HStack(spacing: 16) {
                TitleTextField(
                    title: "Previously",
                    placeholder: "Value",
                    text: $store.previouslyCounterText
                )
                .onChange(of: store.previouslyCounterText) { _, newValue in
                    store.previouslyCounterText = newValue.formatted(.priceInput)
                }
                
                TitleTextField(
                    title: "Current",
                    placeholder: "Value",
                    text: $store.currentCounterText
                )
                .onChange(of: store.currentCounterText) { _, newValue in
                    store.currentCounterText = newValue.formatted(.priceInput)
                }
            }
            .keyboardType(.numberPad)
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
                price: Shared(.calculate(value: 58, count: 2))
            )
        ) {
            AddPriceFeature()
        }
    )
}
