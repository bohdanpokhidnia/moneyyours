//
//  AddAddressView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct FullActionButtonStyle: ButtonStyle {
    @Dependency(\.appColor) private var appColor
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(isEnabled ? appColor.tint : .pastelGrey)
            .padding(.horizontal, 16)
            .overlay {
                configuration.label
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.vertical, 12)
            }
            .frame(maxHeight: 56)
    }
}

struct AddAddressView: View {
    @Bindable var store: StoreOf<AddAddressFeature>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Add new address")
                    .font(.system(size: 28, weight: .bold))
                
                Text("Or other any name")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.starDust)
            }
            .padding(.leading, 16)
            
            TextField("Address name", text: $store.address.name.sending(\.setAddress))
                .textFieldStyle(GrayTextField())
                .padding(16)
            
            Spacer()
            
            Button("Save") {
                store.send(.saveButtonTapped)
            }
            .padding(.bottom, 24)
            .buttonStyle(
                FullActionButtonStyle()
            )
            .disabled(store.state.isSaveDisabled)
        }
    }
}

#Preview {
    NavigationStack {
        AddAddressView(
            store: Store(
                initialState: AddAddressFeature.State(
                    isSaveDisabled: true,
                    address: Address(name: "")
                )) {
                    AddAddressFeature()
                }
        )
    }
}
