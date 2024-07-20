//
//  MonthInvoicesListView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import SwiftUI
import ComposableArchitecture

struct MonthInvoicesListView: View {
    @Bindable var store: StoreOf<MonthInvoicesList>
    
    var body: some View {
        ScrollableGradientHeaderView(
            title: store.monthInvoice.month.name,
            configuration: GradientHeaderConfiguration(presetColors: .addresses),
            headerHeight: 147,
            minVisibleHeight: 17
        ) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(store.monthInvoice.invoices) { (invoice) in
                    InvoiceRow(invoice: invoice)
                }
            }
            .padding([.horizontal, .top], 16)
            
            Button("Add invoice") {
                store.send(.addInvoiceButtonTapped)
            }
            .buttonStyle(SystemImageButtonStyle(imageSystemName: "plus.circle.fill"))
            .tint(.black)
            .padding(16)
        }
        .updateBackButton(color: .white)
        .ignoresSafeArea(edges: .top)
        .background(.appBackground)
    }
}

#Preview {
    NavigationStack {
        MonthInvoicesListView(store: Store(
            initialState: MonthInvoicesList.State(
                monthInvoice: Shared(.mock)
            )
        ) {
            MonthInvoicesList()
        })
    }
}
