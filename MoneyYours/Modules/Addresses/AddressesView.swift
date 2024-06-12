//
//  AddressesView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct AddressesView: View {
    @Bindable var store: StoreOf<AddressesFeature>
    
    private let headerGradient = Gradient(colors: [.cerulean, .richElectricBlue, .frenchBlue])
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack(alignment: .leading, spacing: 0) {
                headerView
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
            .ignoresSafeArea(edges: .top)
            .background(.appBackground)
        } destination: { (store) in
            switch store.case {
            case let .addAddress(store):
                AddAddressView(store: store)
            }
        }
    }
    
    private var headerView: some View {
        LinearGradient(
            gradient: headerGradient,
            startPoint: UnitPoint(x: 0.11966469444160704, y: 8.33727533122719e-8),
            endPoint: UnitPoint(x: 0.8125000346174127, y: 0.9733925237930536)
        )
    }
    
    private var titleText: some View {
        Text("Addresses")
            .font(.system(size: 28, weight: .bold))
            .foregroundStyle(.white)
    }
    
    private var actionButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                NavigationLink(
                   state: AddressesFeature.Path.State.addAddress(AddAddressFeature.State(address: Address(name: "")))
                 ) {
                   Text("Detail")
                 }
                .buttonStyle(ActionAddressesButtonStyle(
                    title: "Add address",
                    emoji: "🏠",
                    emojiBackground: .chromeYellow
                ))
                
                Button("Archive") {
                    
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        title: "Archive",
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
                    Button(address.name) {
                        
                    }
                    .buttonStyle(AddressesButtonStyle())
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
        AddressesView(store: Store(
            initialState: AddressesFeature.State(
                addresses: [.init(name: "м. Полтава, вул. Клінкерна, буд. 13, кв. 1")]
            )) {
                AddressesFeature()
            })
    }
}

#Preview("Dark") {
    AddressesView(store: Store(initialState: AddressesFeature.State(
        addresses: [.init(name: "м. Полтава, вул. Клінкерна, буд. 13, кв. 1")]
    )) {
        AddressesFeature()
    })
    .preferredColorScheme(.dark)
}
