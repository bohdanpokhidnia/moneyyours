//
//  AddAddressView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import ComposableArchitecture
import SwiftUI

struct AddAddressView: View {
    @Bindable var store: StoreOf<AddAddressFeature>
    
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
                text: $store.addressName,
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
                BottomActionButtonStyle(fillColor: .beanRed)
            )
            .disabled(store.isDisableSaveButton)
        }
        .background(.appBackgroundSecondary)
        .updateBackButton(color: .beanRed)
    }
}

#Preview {
    AddAddressView(
        store: Store(
            initialState: AddAddressFeature.State()
        ) {
            AddAddressFeature()
        }
    )
}
