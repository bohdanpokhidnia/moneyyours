//
//  AddressesView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct AddressesView: View {
    @ObservedObject var viewModel: AddressesViewModel
    @State private var invoiceName: String = "Name"
    @State private var communalInvoiceType: CommunalInvoiceType = .notSelected
    @State private var month: Month = .unknown
    @State private var price: Price = .fixed(id: UUID(), value: .zero)
    
    var body: some View {
        NavigationStack(path: $viewModel.coordinator.path) {
            VStack(alignment: .leading, spacing: 0) {
                GradientHeaderView(configuration: .addresses)
                    .frame(height: safeArea.bottom == .zero ? 147 : 187)
                    .padding(.bottom, -111)
                
                titleText
                    .padding(.leading, 16)
                
                actionButtons
                    .padding(.top, 32)
                
                subtitleText
                    .padding(.top, 16)
                    .padding(.leading, 16)
                
                addressesList
                    .padding(.top, 24)
            }
            .ignoresSafeArea(.container, edges: [.top])
            .background(.appBackground)
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .addAddress:
                    AddAddressView(
                        viewModel: AddAddressViewModel(
                            coordinator: viewModel.coordinator
                        )
                    )
                    
                case let .addressDetails(addressId):
                    AddressView(
                        viewModel: AddressViewModel(
                            coordinator: viewModel.coordinator,
                            addressId: addressId
                        )
                    )
                    
                case let .addInvoice(monthInvoice):
                    AddInvoiceView(
                        viewModel: AddInvoiceViewModel(
                            coordinator: viewModel.coordinator,
                            monthInvoice: monthInvoice,
                            name: $invoiceName,
                            invoiceType: $communalInvoiceType,
                            price: $price
                        )
                    )
                    
                case let .addressSettings(address):
                    AddressSettingsView(
                        viewModel: AddressSettingsViewModel(
                            coordinator: viewModel.coordinator,
                            address: address
                        )
                    )
                    
                case .selectCommunalInvoice:
                    SelectCommunalInvoiceTypeView(
                        viewModel: SelectCommunalInvoiceTypeViewModel(
                            coordinator: viewModel.coordinator,
                            selectedInvoiceType: $communalInvoiceType
                        )
                    )
                    
                case .selectPrice:
                    SelectPriceView(
                        viewModel: SelectPriceViewModel(
                            coordinator: viewModel.coordinator,
                            price: $price
                        )
                    )
                    
                case let .addMonth(addressId):
                    AddMonthView(
                        viewModel: AddMonthViewModel(
                            coordinator: viewModel.coordinator,
                            addressId: addressId
                        )
                    )
                    
                case let .month(monthInvoice):
                    MonthView(
                        viewModel: MonthViewModel(
                            coordinator: viewModel.coordinator,
                            monthInvoice: monthInvoice
                        )
                    )
                    
                case let .summary(communalInvoiceLists):
                    SummaryView(
                        viewModel: SummaryViewModel(
                            coordinator: viewModel.coordinator,
                            communalInvoiceLists: communalInvoiceLists
                        )
                    )
                }
            }
            .sheet(
                item: viewModel.$coordinator.presentedSheet,
                onDismiss: {
                    viewModel.coordinator.onDismiss?(viewModel.coordinator.lastPresentedSheet)
                }
            ) { sheet in
                switch sheet {
                case .selectPriceType:
                    SelectPriceTypeView(
                        viewModel: SelectPriceTypeViewModel(
                            coordinator: viewModel.coordinator,
                            priceKind: $price.kind
                        )
                    )
                    .presentationDetents([.height(260)])
                }
            }
            .alert(
                viewModel.coordinator.presentedAlert?.title ?? "Unknown title",
                isPresented: viewModel.coordinator.isPresentedAlert,
            ) {
                if let actions = viewModel.coordinator.presentedAlert?.actions {
                    ForEach(actions) { action in
                        Button(
                            action.title,
                            role: action.role,
                            action: action.action
                        )
                    }
                }
            } message: {
                if let message = viewModel.coordinator.presentedAlert?.message {
                    Text(message)
                }
            }
        }
    }
    
    private var titleText: some View {
        Text("Addresses")
            .foregroundStyle(.white)
            .font(.screenTitle)
    }
    
    private var actionButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                Button("Add address") {
                    viewModel.addAddressButtonTapped()
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        emoji: "🏠",
                        emojiBackground: .fuelYellow
                    )
                )
                
                Button("Archive") {
                    
                }
                .buttonStyle(
                    ActionAddressesButtonStyle(
                        emoji: "📁",
                        emojiBackground: .sunglow
                    )
                )
            }
            .padding(.horizontal, 16)
        }
        .lightThemeShadow()
    }
    
    private var subtitleText: some View {
        Text("Your addresses")
            .foregroundStyle(.foreground)
            .font(.system(size: 22, weight: .semibold))
    }
    
    private var addressesList: some View {
        VStack(spacing: 16) {
            List {
                ForEach(viewModel.addresses) { address in
                    Button {
                        viewModel.tappedAt(address: address)
                    } label: {
                        Text(address.name)
                    }
                    .buttonStyle(
                        EmojiRowButtonStyle(
                            emoji: "🗂️",
                            emojiBackground: .paleBlueLily
                        )
                    )
                }
                .onDelete { indexSet in
                    viewModel.deleteAddress(at: indexSet)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(16)
        .scrollBounceBehavior(.basedOnSize)
    }
}

import SharingGRDB

#Preview {
    @Previewable @ObservedObject var coordinator  = Coordinator()
    
    let _ = prepareDependencies {
        let databaseQueue = try! DatabaseQueue(path: mockDBURL().path)
        try! createPriceTable(for: databaseQueue)
        try! createAddressTable(for: databaseQueue)
        try! createMonthInvoicesTable(for: databaseQueue)
        try! createCommunalInvoiceTable(for: databaseQueue)
        $0.defaultDatabase = databaseQueue
    }
    
    AddressesView(
        viewModel: AddressesViewModel(coordinator: coordinator)
    )
}
