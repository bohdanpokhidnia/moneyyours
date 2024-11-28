//
//  AddressSettingsView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 06.07.2024.
//

import ComposableArchitecture
import SwiftUI

struct AddressSettingsView: View {
    @Bindable var store: StoreOf<AddressSettingsFeature>
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: "Settings",
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
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
                            text: $store.address.name
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
                    store.send(.addToArchiveButtonTapped)
                }
                .buttonStyle(ImageButtonStyle(image: Image(systemName: "archivebox")))
                .tint(.gray)
                
                Button("Remove address") {
                    store.send(.removeButtonTapped)
                }
                .buttonStyle(ImageButtonStyle(image: Image(systemName: "trash")))
                .tint(.beanRed)
            }
            .padding([.top, .horizontal], 16)
        }
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
        .updateBackButton(color: .white)
        .alert($store.scope(state: \.destination?.removeAlert, action: \.destination.removeAlert))
        .alert($store.scope(state: \.destination?.archiveAlert, action: \.destination.archiveAlert))
    }
}

#Preview {
    NavigationStack {
        AddressSettingsView(
            store: Store(
                initialState: AddressSettingsFeature.State(address: Shared(.preview))
            ) {
                AddressSettingsFeature()
            }
        )
    }
}
