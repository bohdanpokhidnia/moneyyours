//
//  SummaryView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2025.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            DynamicTitleGradientHeaderView(
                title: "Summary",
                titleColor: .primaryText,
                configuration: .clear
            )
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.communalInvoiceLists) { communalInvoiceList in
                    SummaryRow(
                        item: communalInvoiceList.invoice.type,
                        title: communalInvoiceList.invoice.name,
                        price: communalInvoiceList.price
                    )
                    .padding(.top, viewModel.communalInvoiceLists.first == communalInvoiceList ? 16 : 0)
                    .padding(.horizontal, 16)
                    .padding(.bottom, viewModel.communalInvoiceLists.last == communalInvoiceList ? 8 : 0)
                    
                    Divider()
                }
                
                Text("Sum")
                    .fontWeight(.regular)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                
                Text(viewModel.sum.formatted(.ua))
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 26))
            .padding([.top, .horizontal], 16)
            
            Spacer()
        }
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
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
        SummaryView(
            viewModel: SummaryViewModel(
                coordinator: .preview,
                communalInvoiceLists: [.init(title: "Test", invoice: .preview, price: 100)]
            )
        )
    }
}
