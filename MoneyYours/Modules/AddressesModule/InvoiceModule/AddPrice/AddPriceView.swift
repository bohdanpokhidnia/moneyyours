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
            
            saveButton
        }
        .overlay(alignment: .top) {
            contentView
        }
        .padding([.horizontal, .bottom], 16)
        .background(.invoiceBackground)
        .updateBackButton(color: .beanRed)
        .bind($store.focus, to: $focus)
        .sheet(item: $store.scope(state: \.selectPrice, action: \.selectPrice)) { store in
            SelectPriceView(store: store)
                .presentationDetents([.height(260)])
        }
    }
}

private extension AddPriceView {
    private var contentView: some View {
        VStack(spacing: 32) {
            Button {
                send(.priceTapped)
            } label: {
                SelectPriceRow(
                    emoji: store.price.wrappedValue.emoji,
                    title: store.price.wrappedValue.name
                )
            }
            
            priceTextField
            
            additionalFields
        }
    }
    
    private var priceTextField: some View {
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
    
    @ViewBuilder
    private var additionalFields: some View {
        switch store.price.wrappedValue {
        case .fixed:
            EmptyView()
            
        case .calculate:
            calculatePriceView
            
        case .multi:
            multiPriceView
        }
    }
    
    private var calculatePriceView: some View {
        HStack(spacing: 16) {
            TitleTextField(
                title: "Previously count",
                placeholder: "Value",
                text: $store.previouslyCounterText
            )
            .onChange(of: store.previouslyCounterText) { _, newValue in
                store.previouslyCounterText = newValue.formatted(.priceInput)
            }
            
            TitleTextField(
                title: "Current count",
                placeholder: "Value",
                text: $store.currentCounterText
            )
            .onChange(of: store.currentCounterText) { _, newValue in
                store.currentCounterText = newValue.formatted(.priceInput)
            }
        }
        .keyboardType(.numberPad)
    }
    
    private var multiPriceView: some View {
        VStack(spacing: 16) {
            calculatePriceView
            
            Divider()
            
            HStack(spacing: 16) {
                TitleTextField(
                    title: "Previously count",
                    placeholder: "Value",
                    text: $store.multiPreviouslyCounterText
                )
                .onChange(of: store.multiPreviouslyCounterText) { _, newValue in
                    store.multiPreviouslyCounterText = newValue.formatted(.priceInput)
                }
                
                TitleTextField(
                    title: "Current count",
                    placeholder: "Value",
                    text: $store.multiCurrentCounterText
                )
                .onChange(of: store.multiCurrentCounterText) { _, newValue in
                    store.multiCurrentCounterText = newValue.formatted(.priceInput)
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
                price: Shared(
                    .multi(
                        first: .calculate(value: 10, count: 1),
                        second: .calculate(value: 10, count: 1)
                    )
                )
            )
        ) {
            AddPriceFeature()
        }
    )
}
