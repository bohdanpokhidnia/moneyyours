//
//  AddressesView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: AddressesFeature.self)
struct AddressesView: View {
    @Bindable var store: StoreOf<AddressesFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack(alignment: .leading, spacing: 0) {
                GradientHeaderView(
                    configuration: GradientHeaderConfiguration(presetColors: .addresses)
                )
                .frame(height: safeArea.bottom == .zero ? 147 : 187)
                .padding(.bottom, -111)
                    
                titleText
                    .padding(.leading, 16)
                
                actionButtons
                    .padding(.top, 32)
                
                if store.contentState.isNotEmptyState {
                    subtitleText
                        .padding(.top, 16)
                        .padding(.leading, 16)
                }
                
                switch store.contentState {
                case let .content(content):
                    addressesList(content)
                        .padding(.top, 24)
                    
                case let .empty(state):
                    TextEmptyStateView(state: state)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .ignoresSafeArea(.container, edges: [.top])
            .background(.appBackground)
            .onAppear {
                send(.onAppear)
            }
        } destination: { (store) in
            switch store.case {
            case let .addAddress(store):
                AddAddressView(store: store)
                
            case let .address(store):
                AddressView(store: store)
                
            case let .addressSettings(store):
                AddressSettingsView(store: store)
                
            case let .archivedAddresses(store):
                ArchivedAddressesView(store: store)
                
            case let .monthInvoicesList(store):
                MonthInvoicesListView(store: store)
                
            case let .invoiceSelectionList(store):
                InvoiceSelectionListView(store: store)
            }
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
                    send(.addButtonTapped)
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        emoji: "🏠",
                        emojiBackground: .fuelYellow
                    )
                )
                
                Button("Archive") {
                    send(.archiveButtonTapped)
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
    
    private func addressesList(_ activeAddresses: Shared<IdentifiedArrayOf<Address>>) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(activeAddresses) { $address in
                    NavigationLink(state: AddressesFeature.Path.State.address(AddressFeature.State(address: $address))) {
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
            .padding(.horizontal, 16)
        }
        .scrollBounceBehavior(.basedOnSize)
        .lightThemeShadow()
    }
}

#Preview {
    NavigationStack {
        AddressesView(
            store: Store(initialState: AddressesFeature.State(addresses: [])) {
                AddressesFeature()
            }
        )
    }
}
