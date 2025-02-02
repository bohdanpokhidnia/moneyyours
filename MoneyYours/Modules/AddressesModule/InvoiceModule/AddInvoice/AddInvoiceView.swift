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
        ScrollableGradientHeaderView(
            title: "Add invoice",
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
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
                    inputType: .text(store.invoiceType.name)
                )
                
                Button {
                    send(.monthButtonTapped)
                } label: {
                    EmojiFieldView(
                        title: "Month",
                        emoji: store.month.wrappedValue.emoji,
                        emojiBackground: store.month.wrappedValue.color,
                        inputType: .text(store.month.wrappedValue.name)
                    )
                }
                
                Button {
                    send(.priceButtonTapped)
                } label: {
                    EmojiFieldView(
                        title: "Price",
                        emoji: "💵",
                        emojiBackground: Color(hex: "#D4EFDF"),
                        inputType: .text(store.price.sum.formatted(.ukrainianHryvnia))
                    )
                }
            }
            .padding(16)
            .lightThemeShadow()
            
            Button("Save") {
                send(.saveButtonTapped)
            }
            .buttonStyle(
                BottomActionButtonStyle(fillColor: .beanRed)
            )
            .disabled(store.isDisableSaveButton)
            .frame(height: 56)
            .padding(16)
        }
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    send(.backButtonTapped)
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddInvoiceView(
            store: Store(
                initialState: AddInvoiceFeature.State(month: Shared(.january)),
                reducer: {
                    AddInvoiceFeature()
                }
            )
        )
    }
}
