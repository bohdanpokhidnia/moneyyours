//
//  AddressesView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct AddressesView: View {
    @ObservedObject var viewModel: AddressesViewModel
    
    var body: some View {
        CoordinatorNavigationStack(coordinator: viewModel.coordinator) {
            VStack(alignment: .leading, spacing: 0) {
                GradientHeaderView(configuration: .addresses)
                    .frame(height: safeArea.bottom == .zero ? 147 : 187)
                    .padding(.bottom, -111)
                
                titleText
                    .padding(.leading, 16)
                
                actionButtons
                    .padding(.top, 32)
                
                subtitleText
                    .padding(.top, 16)
                    .padding(.leading, 16)
                
                addressesList
                    .padding(.top, 24)
            }
            .ignoresSafeArea(.container, edges: [.top])
            .background(.appBackground)
        }
    }
    
    private var titleText: some View {
        Text("Addresses")
            .foregroundStyle(.white)
            .font(.screenTitle)
    }
    
    private var actionButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                Button("Add address") {
                    viewModel.addAddressButtonTapped()
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        emoji: "🏠",
                        emojiBackground: .fuelYellow
                    )
                )
                
                Button("Archive") {
                    
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        emoji: "📁",
                        emojiBackground: .sunglow
                    )
                )
            }
            .padding(.horizontal, 16)
        }
        .lightThemeShadow()
    }
    
    private var subtitleText: some View {
        Text("Your addresses")
            .foregroundStyle(.foreground)
            .font(.system(size: 22, weight: .semibold))
    }
    
    private var addressesList: some View {
        VStack(spacing: 16) {
            List {
                ForEach(viewModel.addresses) { address in
                    Button {
                        viewModel.tappedAt(address: address)
                    } label: {
                        Text(address.name)
                    }
                    .buttonStyle(
                        EmojiRowButtonStyle(
                            emoji: "🗂️",
                            emojiBackground: .paleBlueLily
                        )
                    )
                }
                .onDelete { indexSet in
                    viewModel.deleteAddress(at: indexSet)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(16)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    @Previewable var coordinator = Coordinator()
    
    PreviewDatabaseDependencies {
        AddressesView(
            viewModel: AddressesViewModel(coordinator: coordinator)
        )
    }
}
