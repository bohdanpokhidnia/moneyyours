//
//  ArchivedAddressesView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.11.2024.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: ArchivedAddressesFeature.self)
struct ArchivedAddressesView: View {
    @Bindable var store: StoreOf<ArchivedAddressesFeature>
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: "Archived Addresses",
            configuration: GradientHeaderConfiguration(presetColors: .addresses),
            isScrollDisabled: store.addresses.wrappedValue.isBindingEmpty
        ) {
            VStack {
                ForEach(store.addresses.elements) { $address in
                    Button {
                        send(.addressButtonTapped(address: $address.wrappedValue))
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
        .alert($store.scope(state: \.returnAlert, action: \.returnAlert))
    }
}

#Preview {
    NavigationStack {
        ArchivedAddressesView(
            store: Store(
                initialState: ArchivedAddressesFeature.State(addresses: Shared([.archivedAddress])),
                reducer: {
                    ArchivedAddressesFeature()
                }
            )
        )
    }
}
