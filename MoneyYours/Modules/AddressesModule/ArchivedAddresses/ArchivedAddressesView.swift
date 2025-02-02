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
            isScrollDisabled: store.addresses.isBindingEmpty
        ) {
            VStack {
                ForEach(store.addresses) { address in
                    Button {
                        send(.addressButtonTapped(address: address))
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
        .onAppear {
            send(.onAppear)
        }
        .ignoresSafeArea(edges: .top)
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    send(.backButtonTapped)
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.white)
                }
            }
        }
        .alert($store.scope(state: \.returnAlert, action: \.returnAlert))
    }
}

#Preview {
    NavigationStack {
        ArchivedAddressesView(
            store: Store(
                initialState: ArchivedAddressesFeature.State(addresses: [.archivedAddress]),
                reducer: {
                    ArchivedAddressesFeature()
                }
            )
        )
    }
}
