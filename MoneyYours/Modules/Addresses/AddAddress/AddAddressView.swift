//
//  AddAddressView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct AddAddressView: View {
    @Bindable var store: StoreOf<AddAddress>
    @Dependency(\.appColor) private var appColor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Add new address")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.primaryText)
                
                Text("Or other any name")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.starDust)
            }
            .padding(.leading, 16)
            
            TextField(
                "",
                text: $store.address.name.sending(\.setAddress),
                prompt: Text("Address name").foregroundStyle(.starDust)
            )
            .textFieldStyle(GrayTextField())
            .padding(16)
            
            Spacer()
            
            Button("Save") {
                store.send(.saveButtonTapped)
            }
            .padding(.bottom, 24)
            .buttonStyle(
                BottomActionButtonStyle()
            )
            .disabled(store.state.isSaveDisabled)
        }
        .background(.appBackgroundSecondary)
        .updateBackButton(color: appColor.tint)
    }
}

#Preview("Light") {
    NavigationStack {
        AddAddressView(
            store: Store(
                initialState: AddAddress.State(
                    isSaveDisabled: true,
                    address: Address(name: "")
                )) {
                    AddAddress()
                }
        )
    }
}

#Preview("Dark") {
    NavigationStack {
        AddAddressView(
            store: Store(
                initialState: AddAddress.State(
                    isSaveDisabled: true,
                    address: Address(name: "")
                )) {
                    AddAddress()
                }
        )
        .environment(\.colorScheme, .dark)
    }
}