//
//  AddressView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI


struct AddressView: View {
    @ObservedObject var viewModel: AddressViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            DynamicTitleGradientHeaderView(
                title: viewModel.address?.name ?? "Address",
                configuration: .addresses
            )
            
            subtitleText
                .padding(.leading, 16)
            
            List {
                ForEach(viewModel.monthInvoiceLists) { monthInvoiceList in
                    Text(monthInvoiceList.year.description)
                        .frame(maxWidth: .infinity)
                    
                    ForEach(monthInvoiceList.monthInvoices) { monthInvoice in
                        Button(monthInvoice.month.name) {
                            viewModel.monthButtonTapped(monthInvoice: monthInvoice)
                        }
                        .buttonStyle(EmojiRowButtonStyle(item: monthInvoice.month))
                    }
                    .onDelete { indexSet in
                        viewModel.deleteMonth(at: indexSet)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(16)
        .scrollBounceBehavior(.basedOnSize)
        .ignoresSafeArea(edges: [.top])
        .background(.appBackground)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    viewModel.backButtonTapped()
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.white)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 8) {
                    Button {
                        viewModel.addMonthButtonTapped()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    }
                    
                    Button {
                        viewModel.settingsButtonTapped()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.white)
                    }
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
                Text("Months")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(.primaryText)
                
                Text("Add month for billing")
                    .foregroundStyle(.starDust)
                    .font(.system(size: 14, weight: .regular))
            }
            
            Spacer()
        }
    }
}

#Preview {
    @Previewable var viewModel = AddressViewModel(
        coordinator: .preview,
        addressId: UUID(1),
        monthInvoiceLists: [
            .init(
                year: 2025,
                monthInvoices: [
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                ]
            ),
            .init(
                year: 2024,
                monthInvoices: [
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                    .preview,
                ]
            )
        ]
    )
    
    PreviewDatabaseDependencies {
        NavigationStack {
            AddressView(viewModel: viewModel)
                .setupNavigationTransparent()
        }
    }
}
