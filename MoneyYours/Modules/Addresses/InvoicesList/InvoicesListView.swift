//
//  InvoicesListView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct InvoicesListView: View {
    @Bindable var store: StoreOf<InvoicesList>
    
    var body: some View {
        VStack(spacing: 0) {
            TitleGradientHeaderView(
                title: "Invoices",
                presetColors: .addresses
            )
            .frame(height: 147)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(store.invoices) { (invoice) in
                        Button(invoice.type.name) {
                            store.send(.select(invoice))
                        }
                        .buttonStyle(
                            SelectInvoiceButtonStyle(
                                emoji: invoice.type.emoji,
                                emojiBackground: invoice.type.emojiBackground
                            )
                        )
                    }
                }
                .padding(16)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .ignoresSafeArea(edges: .top)
        .updateBackButton(color: .white)
        .background(.appBackground)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview("Light") {
    InvoicesListView(
        store: Store(
            initialState: InvoicesList.State(
                invoices: [.mock]
            )
        ) {
            InvoicesList()
        }
    )
}

#Preview("Dark") {
    InvoicesListView(
        store: Store(
            initialState: InvoicesList.State(
                invoices: [.mock]
            )
        ) {
            InvoicesList()
        }
    )
    .environment(\.colorScheme, .dark)
}
