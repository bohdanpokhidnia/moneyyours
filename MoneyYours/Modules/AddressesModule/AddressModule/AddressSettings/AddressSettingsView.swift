//
//  AddressSettingsView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 06.07.2024.
//

import SwiftUI

struct AddressSettingsView: View {
    @ObservedObject var viewModel: AddressSettingsViewModel
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: "Settings",
            configuration: .addresses
        ) {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    EmojiView(
                        emoji: "📁",
                        emojiBackground: .rubberDuckyYellow
                    )
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Address name")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color(hex: "#9A9A9A"))
                        
                        TextField(
                            "",
                            text: $viewModel.address.name
                        )
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundStyle(.primaryText)
                    }
                }
                .padding(24)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.top, 24)
            .padding(.horizontal, 16)
            
            VStack(spacing: 16) {
                Button("Add to archive") {

                }
                .buttonStyle(ImageButtonStyle(image: Image(systemName: "archivebox")))
                .tint(.gray)
                
                Button("Remove address") {

                }
                .buttonStyle(ImageButtonStyle(image: Image(systemName: "trash")))
                .tint(.beanRed)
                
                Button("Save") {
                    viewModel.saveButtonTapped()
                }
                .buttonStyle(
                    BottomActionButtonStyle(fillColor: .beanRed)
                )
                .frame(height: 52)
            }
            .padding([.top, .horizontal], 16)
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
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddressSettingsView(
            viewModel: AddressSettingsViewModel(
                coordinator: .preview,
                address: .activeAddress
            )
        )
    }
}
