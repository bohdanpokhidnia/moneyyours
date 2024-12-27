//
//  AddInvoiceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 17.12.2024.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: AddInvoiceFeature.self)
struct AddInvoiceView: View {
    @Bindable var store: StoreOf<AddInvoiceFeature>
    
    var body: some View {
        VStack(spacing: 0) {
            TitleGradientHeaderView(
                title: "Add invoice",
                configuration: GradientHeaderConfiguration(presetColors: .addresses)
            )
            .frame(height: 147)
            
            ScrollView {
                VStack(spacing: 16) {
                    EmojiFieldView(
                        title: "Invoice name",
                        emoji: "🧾",
                        emojiBackground: Color(hex: "#F5F5F5"),
                        inputType: .textFiled(text: $store.name)
                    )
                    
                    EmojiFieldView(
                        title: "Invoice type",
                        emoji: store.invoiceType.emoji,
                        emojiBackground: store.invoiceType.emojiBackground,
                        inputType: .text(
                            text: Binding(get: { store.invoiceType.name }),
                            action: {
                                send(.invoiceButtonTapped)
                            }
                        )
                    )
                    
                    Picker(
                        "Price",
                        selection: $store.selectedPrice
                    ) {
                        ForEach(Price.allCases, id: \.self) { price in
                            Text(price.name)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    priceInput(for: store.selectedPrice)
                }
                .padding(16)
            }
            
            Button("Save") {
                send(.saveButtonTapped)
            }
            .buttonStyle(
                BottomActionButtonStyle(fillColor: .beanRed)
            )
            .padding([.bottom, .horizontal], 16)
        }
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
        .updateBackButton(color: .white)
    }
    
    @ViewBuilder
    private func priceInput(for price: Price) -> some View {
        switch price {
        case .fixed:
            EmojiFieldView(
                title: "Price",
                emoji: "",
                emojiBackground: .red,
                inputType: .textFiled(text: $store.fixedValue),
                keyboardType: .decimalPad
            )
            
        case .calculate:
            HStack(spacing: 16) {
                EmojiFieldView(
                    title: "Price",
                    emoji: "",
                    emojiBackground: .blue,
                    inputType: .textFiled(text: $store.calculateValue),
                    keyboardType: .decimalPad
                )
                
                EmojiFieldView(
                    title: "Count",
                    emoji: "",
                    emojiBackground: .yellow,
                    inputType: .textFiled(text: $store.calculateCount),
                    keyboardType: .numberPad
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddInvoiceView(
            store: Store(
                initialState: AddInvoiceFeature.State(),
                reducer: {
                    AddInvoiceFeature()
                }
            )
        )
    }
}
