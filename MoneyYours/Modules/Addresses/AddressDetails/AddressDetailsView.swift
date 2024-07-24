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
        ScrollableGradientHeaderView(
            title: store.address.name,
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
            VStack(alignment: .leading, spacing: 16) {
                subtitleText
                
                ForEach(store.address.yearInvoices) { (yearInvoice) in
                    Text(yearInvoice.year.description)
                        .frame(maxWidth: .infinity)
                    
                    ForEach(yearInvoice.monthInvoices) { (monthInvoice) in
                        Button(monthInvoice.month.name) {
                            store.send(.monthInvoiceButtonTapped(yearInvoice, monthInvoice))
                        }
                        .buttonStyle(
                            EmojiRowButtonStyle(
                                emoji: monthInvoice.month.emoji,
                                emojiBackground: monthInvoice.month.color
                            )
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
        }
        .ignoresSafeArea(edges: [.top])
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
                    .foregroundStyle(.primaryText)
                
                Text("Add invoices for billing")
                    .foregroundStyle(.starDust)
                    .font(.system(size: 14, weight: .regular))
            }
            
            Spacer()
        }
        .padding([.top, .leading], 16)
    }
}

#Preview {
    NavigationStack {
        AddressDetailsView(
            store: Store(
                initialState: AddressDetails.State(address: Shared(.mock))
            ) {
                AddressDetails()
            }
        )
        .setupNavigationTransparent()
    }
}
