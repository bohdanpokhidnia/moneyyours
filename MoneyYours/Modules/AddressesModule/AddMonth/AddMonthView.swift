//
//  AddMonthView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import SwiftUI

struct AddMonthView: View {
    @ObservedObject var viewModel: AddMonthViewModel
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: "Add month",
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
            VStack(spacing: 16) {
                ForEach(viewModel.months) { month in
                    Button(month.name) {
                        viewModel.select(month: month)
                    }
                    .buttonStyle(
                        EmojiRowButtonStyle(
                            emoji: month.emoji,
                            emojiBackground: month.color
                        )
                    )
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .ignoresSafeArea(edges: .top)
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
        AddMonthView(
            viewModel: AddMonthViewModel(
                coordinator: .preview,
                addressId: UUID(1)
            )
        )
    }
}
