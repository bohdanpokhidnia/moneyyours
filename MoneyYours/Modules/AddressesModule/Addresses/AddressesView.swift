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
    @State private var communalInvoiceType: CommunalInvoiceType = .unknown
    @State private var month: Month = .unknown
    @State private var price: Price = .fixed(id: UUID(), value: .zero)
    
    var body: some View {
        NavigationStack(path: $viewModel.coordinator.path) {
            VStack(alignment: .leading, spacing: 0) {
                GradientHeaderView(
                    configuration: GradientHeaderConfiguration(presetColors: .addresses)
                )
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
                    
                case let .addressDetails(address):
                    AddressView(
                        viewModel: AddressViewModel(
                            coordinator: viewModel.coordinator,
                            address: address
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
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
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
            }
            .padding(.horizontal, 16)
        }
        .scrollBounceBehavior(.basedOnSize)
        .lightThemeShadow()
    }
}
