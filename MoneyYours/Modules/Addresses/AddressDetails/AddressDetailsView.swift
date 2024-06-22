//
//  AddressDetailsView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct AddressDetailsView: View {
    @Bindable var store: StoreOf<AddressDetails>
    
    var body: some View {
        VStack(spacing: 0) {
            TitleGradientHeaderView(
                title: store.address.name,
                presetColors: .addresses
            )
            .frame(height: 147)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    subtitleText
                    
                    ForEach(store.address.invoices) { (invoice) in
                        HStack {
                            Text(invoice.type.emoji)
                            Text(invoice.type.name)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    Button("Add invoice") {
                        store.send(.addInvoiceButtonTapped)
                    }
                    .buttonStyle(AddInvoiceButtonStyle())
                    .padding(.horizontal, 16)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .ignoresSafeArea(edges: .top)
        .updateBackButton(color: .white)
        .background(.appBackground)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

// MARK: - Views

private extension AddressDetailsView {
    private var subtitleText: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Invoices")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.appTitle)
                
                Text("Add invoices for billing")
                    .foregroundStyle(.starDust)
                    .font(.system(size: 14, weight: .regular))
            }
            
            Spacer()
        }
        .padding([.top, .leading], 16)
    }
}

#Preview("Light") {
    NavigationStack {
        AddressDetailsView(
            store: Store(
                initialState: AddressDetails.State(address: .mock)
            ) {
                AddressDetails()
            }
        )
    }
}

#Preview("Dark") {
    NavigationStack {
        AddressDetailsView(
            store: Store(
                initialState: AddressDetails.State(address: .mock)
            ) {
                AddressDetails()
            }
        )
        .environment(\.colorScheme, .dark)
    }
}
