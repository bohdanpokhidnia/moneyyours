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
                        inputType: .text(store.invoiceType.name)
                    )
                    
                    Button {
                        send(.priceButtonTapped)
                    } label: {
                        EmojiFieldView(
                            title: "Price",
                            emoji: "💵",
                            emojiBackground: Color(hex: "#D4EFDF"),
                            inputType: .text("\(store.price.sumString)")
                        )
                    }
                }
                .padding(16)
            }
            
            Button("Save") {
                send(.saveButtonTapped)
            }
            .buttonStyle(
                BottomActionButtonStyle(fillColor: .beanRed)
            )
            .disabled(store.isSaveButtonDisabled)
            .padding([.bottom, .horizontal], 16)
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
                initialState: AddInvoiceFeature.State(),
                reducer: {
                    AddInvoiceFeature()
                }
            )
        )
    }
}
