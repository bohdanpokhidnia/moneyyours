//
//  AddCommunalInvoiceView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 17.12.2024.
//

import SwiftUI

struct AddCommunalInvoiceView: View {
    @ObservedObject var viewModel: AddCommunalInvoiceViewModel
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: "Add communal invoice",
            configuration: .addresses
        ) {
            VStack(spacing: 16) {
                EmojiFieldView(
                    title: "Invoice name",
                    emoji: "🧾",
                    emojiBackground: Color(hex: "#F5F5F5"),
                    inputType: .textFiled(text: viewModel.name)
                )
                
                Button {
                    viewModel.invoiceTypeButtonTapped()
                } label: {
                    EmojiFieldView(
                        title: "Invoice type",
                        emoji: viewModel.communalInvoiceType.wrappedValue.emoji,
                        emojiBackground: viewModel.communalInvoiceType.wrappedValue.color,
                        inputType: .text(viewModel.communalInvoiceType.wrappedValue.name)
                    )
                }
                
                Button {
                    viewModel.priceButtonTapped()
                } label: {
                    EmojiFieldView(
                        title: "Price",
                        emoji: "💵",
                        emojiBackground: Color(hex: "#D4EFDF"),
                        inputType: .text(viewModel.sum)
                    )
                }
                .disabled(viewModel.isDisablePriceButton)
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
    @Previewable @State var communalInvoiceType: CommunalInvoiceType = .internet
    
    PreviewCoordinatorNavigationStack {
        AddCommunalInvoiceView(
            viewModel: AddCommunalInvoiceViewModel(
                coordinator: .preview,
                monthInvoice: .preview,
                name: .constant("Name"),
                communalInvoiceType: $communalInvoiceType,
                price: .constant(.single(id: UUID(5), value: 5.0))
            )
        )
    }
}
