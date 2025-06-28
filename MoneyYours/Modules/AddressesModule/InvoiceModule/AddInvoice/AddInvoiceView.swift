//
//  AddInvoiceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 17.12.2024.
//

import SwiftUI

struct AddInvoiceView: View {
    @ObservedObject var viewModel: AddInvoiceViewModel
    
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
                    inputType: .textFiled(text: $viewModel.name)
                )
                
                Button {
                    viewModel.invoiceTypeButtonTapped()
                } label: {
                    EmojiFieldView(
                        title: "Invoice type",
                        emoji: viewModel.invoiceType.wrappedValue.emoji,
                        emojiBackground: viewModel.invoiceType.wrappedValue.emojiBackground,
                        inputType: .text(viewModel.invoiceType.wrappedValue.name)
                    )
                }
                
                Button {
                    viewModel.monthButtonTapped()
                } label: {
                    EmojiFieldView(
                        title: "Month",
                        emoji: viewModel.month.wrappedValue.emoji,
                        emojiBackground: viewModel.month.wrappedValue.color,
                        inputType: .text(viewModel.month.wrappedValue.name)
                    )
                }
                
                Button {
//                    send(.priceButtonTapped)
                } label: {
                    EmojiFieldView(
                        title: "Price",
                        emoji: "💵",
                        emojiBackground: Color(hex: "#D4EFDF"),
                        inputType: .text(viewModel.price.sum.formatted(.ua))
                    )
                }
            }
            .padding(16)
            .lightThemeShadow()
            
            Button("Save") {
                viewModel.saveButtonTapped()
            }
            .buttonStyle(
                BottomActionButtonStyle(fillColor: .beanRed)
            )
            .disabled(viewModel.isDisableSaveButton)
            .frame(height: 56)
            .padding(16)
        }
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.backButtonTapped()
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
            viewModel: AddInvoiceViewModel(
                coordinator: .preview,
                addressId: UUID(2),
                invoiceType: .constant(.unknown),
                month: .constant(.unknown)
            )
        )
    }
}
