//
//  AddAddressView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct AddAddressView: View {
//    @ObservedObject var viewModel: AddAddressViewModel
    @ObservedObject var viewModel: AddAddressViewModel1
    
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
                text: $viewModel.addressName,
                prompt: Text("Address name").foregroundStyle(.starDust)
            )
            .textFieldStyle(GrayTextField())
            .padding(16)
            
//            if viewModel.isLoading {
//                ProgressView()
//            }
            
            Spacer()
            
            Button("Save") {
                viewModel.saveButtonTapped()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
            .buttonStyle(
                BottomActionButtonStyle(fillColor: .beanRed)
            )
            .disabled(viewModel.isDisableSaveButton)
        }
        .background(.appBackgroundSecondary)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.backButtonTapped()
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.beanRed)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddAddressView(
//            viewModel: AddAddressViewModel(
//                coordinator: .preview
//            )
            viewModel: AddAddressViewModel1(
                coordinator: .preview
            )
        )
    }
}
