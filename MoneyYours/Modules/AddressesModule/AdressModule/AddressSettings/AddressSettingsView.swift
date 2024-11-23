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
    
    @State var name: String = "Test"
    
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.top, 24)
            .padding(.horizontal, 16)
            
            Button("Remove address") {
                
            }
            .buttonStyle(SystemImageButtonStyle(imageSystemName: "trash"))
            .padding(.top, 16)
            .tint(.beanRed)
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
        .updateBackButton(color: .white)
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
