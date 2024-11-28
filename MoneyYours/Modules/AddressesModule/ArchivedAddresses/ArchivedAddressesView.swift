//
//  ArchivedAddressesView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.11.2024.
//

import ComposableArchitecture
import SwiftUI

struct ArchivedAddressesView: View {
    @Bindable var store: StoreOf<ArchivedAddressesFeature>
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: "Archived Addresses",
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
            VStack {
                ForEach(store.addresses.elements) { $address in
                    Button {
                        
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
            }
            .padding([.top, .horizontal], 16)
        }
        .updateBackButton(color: .white)
        .ignoresSafeArea(edges: .top)
        .background(.appBackground)
    }
}

#Preview {
    NavigationStack {
        ArchivedAddressesView(
            store: Store(
                initialState: ArchivedAddressesFeature.State(addresses: Shared(.preview)),
                reducer: {
                    ArchivedAddressesFeature()
                }
            )
        )
    }
}
