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
        VStack(spacing: 16) {
            DynamicTitleGradientHeaderView(
                title: viewModel.monthInvoice.month.title,
                configuration: GradientHeaderConfiguration(presetColors: .addresses)
            )
            
            List {
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
                .onDelete { indexSet in
                    viewModel.deleteMonthInvoice(at: indexSet)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .listRowSpacing(16)
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
