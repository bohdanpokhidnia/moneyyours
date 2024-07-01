//
//  AddressesListView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct AddressesListView: View {
    @Bindable var store: StoreOf<AddressesList>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack(alignment: .leading, spacing: 0) {
                GradientHeaderView(presetColors: .addresses)
                    .frame(height: 187)
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
        } destination: { (store) in
            switch store.case {
            case let .addAddress(store):
                AddAddressView(store: store)
                
            case let .addressDetails(store):
                AddressDetailsView(store: store)
                
            case let .monthInvoicesList(store):
                MonthInvoicesListView(store: store)
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
                NavigationLink(
                    state: AddressesList.Path.State.addAddress(AddAddress.State(address: Address(name: "")))
                ) {
                    Text("Add address")
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        emoji: "🏠",
                        emojiBackground: .chromeYellow
                    )
                )
                
                Button("Archive") {
                    
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        emoji: "🗂️",
                        emojiBackground: .artyClickWarmRed
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
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(store.addresses) { (address) in
                    NavigationLink(state: AddressesList.Path.State.addressDetails(AddressDetails.State(address: address))) {
                        Text(address.name)
                    }
                    .buttonStyle(
                        EmojiRowButtonStyle(
                            emoji: "📁",
                            emojiBackground: .rubberDuckyYellow
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

#Preview("Light") {
    NavigationStack {
        AddressesListView(store: Store(
            initialState: AddressesList.State(
                addresses: [.mock]
            )) {
                AddressesList()
            })
    }
}

#Preview("Dark") {
    AddressesListView(store: Store(initialState: AddressesList.State(
        addresses: [.mock]
    )) {
        AddressesList()
    })
    .preferredColorScheme(.dark)
}