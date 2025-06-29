//
//  MonthView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.06.2025.
//

import SwiftUI

struct MonthView: View {
    @ObservedObject var viewModel: MonthViewModel
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: viewModel.monthInvoice.month.title,
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.communalInvoiceLists) { communalInvoiceList in
                    Button(communalInvoiceList.title) {
                        print("[dev] tapped at \(communalInvoiceList)")
                    }
                    .buttonStyle(
                        EmojiRowButtonStyle(
                            emoji: communalInvoiceList.invoice.type.emoji,
                            emojiBackground: communalInvoiceList.invoice.type.emojiBackground
                        )
                    )
                }
                .padding(.horizontal, 16)
            }
            .padding(.top, 16)
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.addInvoiceButtonTapped()
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MonthView(
            viewModel: MonthViewModel(
                coordinator: .preview,
                monthInvoice: .preview
            )
        )
    }
}
