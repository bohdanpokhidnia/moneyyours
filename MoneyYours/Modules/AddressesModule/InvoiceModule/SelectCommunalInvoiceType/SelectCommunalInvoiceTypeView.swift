//
//  SelectCommunalInvoiceTypeView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI

struct SelectCommunalInvoiceTypeView: View {
    @ObservedObject var viewModel: SelectCommunalInvoiceTypeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            DynamicTitleGradientHeaderView(
                title: "Invoices",
                configuration: .addresses
            )
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.invoiceTypes, id: \.self) { invoiceType in
                        Button(invoiceType.name) {
                            viewModel.select(invoiceType: invoiceType)
                        }
                        .buttonStyle(
                            SelectInvoiceButtonStyle(
                                emoji: invoiceType.emoji,
                                emojiBackground: invoiceType.color
                            )
                        )
                    }
                }
                .padding(16)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .ignoresSafeArea(.container, edges: [.top])
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
    SelectCommunalInvoiceTypeView(
        viewModel: SelectCommunalInvoiceTypeViewModel(
            coordinator: .preview,
            selectedInvoiceType: .constant(.electricity)
        )
    )
}
