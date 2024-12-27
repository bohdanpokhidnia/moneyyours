//
//  AddressView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: AddressFeature.self)
struct AddressView: View {
    @Bindable var store: StoreOf<AddressFeature>
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: store.address.name,
            configuration: GradientHeaderConfiguration(presetColors: .addresses)
        ) {
            VStack(alignment: .leading, spacing: 16) {
                subtitleText
                
                Button("Add invoice") {
                    send(.addInvoiceButtonTapped)
                }
                .buttonStyle(ImageButtonStyle(image: Image(systemName: "plus.circle.fill")))
                .tint(.black)
                .padding(16)
                
                ForEach(store.yeas, id: \.self) { year in
                    Text(year.description)
                        .frame(maxWidth: .infinity)
                    
                    ForEach(store.address.communalInvoices.filter({ $0.year == year })) { communalInvoice in
                        Button(communalInvoice.month.name) {
                            
                        }
                        .buttonStyle(
                            EmojiRowButtonStyle(
                                emoji: communalInvoice.month.emoji,
                                emojiBackground: communalInvoice.month.color
                            )
                        )
                    }
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
        .ignoresSafeArea(edges: [.top])
        .updateBackButton(color: .white)
        .background(.appBackground)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    send(.settingsButtonTapped)
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

// MARK: - Views

private extension AddressView {
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
        AddressView(
            store: Store(
                initialState: AddressFeature.State(address: Shared(.preview))
            ) {
                AddressFeature()
            }
        )
        .setupNavigationTransparent()
    }
}
