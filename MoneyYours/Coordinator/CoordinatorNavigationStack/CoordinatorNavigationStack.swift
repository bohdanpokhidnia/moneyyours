//
//  CoordinatorNavigationStack.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 22.08.2025.
//

import SwiftUI

struct CoordinatorNavigationStack<Content: View>: View {
    @ObservedObject var coordinator: Coordinator
    var content: (() -> Content)
    
    @State private var invoiceName: String = "Name"
    @State private var communalInvoiceType: CommunalInvoiceType = .notSelected
    @State private var month: Month = .unknown
    @State private var price: Price = .single(id: UUID(), value: .zero)
    
    init(
        coordinator: Coordinator,
        content: @escaping () -> Content
    ) {
        self.coordinator = coordinator
        self.content = content
    }
    
    var body: some View {        
        NavigationStack(path: $coordinator.path) {
            content()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .addAddress:
                        AddAddressView(
                            viewModel: AddAddressViewModel(
                                coordinator: coordinator
                            )
                        )
                        
                    case let .addressDetails(addressId):
                        AddressView(
                            viewModel: AddressViewModel(
                                coordinator: coordinator,
                                addressId: addressId
                            )
                        )
                        
                    case let .addInvoice(monthInvoice):
                        AddCommunalInvoiceView(
                            viewModel: AddCommunalInvoiceViewModel(
                                coordinator: coordinator,
                                monthInvoice: monthInvoice,
                                name: $invoiceName,
                                communalInvoiceType: $communalInvoiceType,
                                price: $price
                            )
                        )
                        
                    case let .addressSettings(address):
                        AddressSettingsView(
                            viewModel: AddressSettingsViewModel(
                                coordinator: coordinator,
                                address: address
                            )
                        )
                        
                    case .selectCommunalInvoice:
                        SelectCommunalInvoiceTypeView(
                            viewModel: SelectCommunalInvoiceTypeViewModel(
                                coordinator: coordinator,
                                selectedInvoiceType: $communalInvoiceType
                            )
                        )
                        
                    case .selectPrice:
                        SelectPriceView(
                            viewModel: SelectPriceViewModel(
                                coordinator: coordinator,
                                price: $price,
                                communalInvoiceType: communalInvoiceType
                            )
                        )
                        
                    case let .addMonth(addressId):
                        AddMonthView(
                            viewModel: AddMonthViewModel(
                                coordinator: coordinator,
                                addressId: addressId
                            )
                        )
                        
                    case let .month(monthInvoice):
                        MonthView(
                            viewModel: MonthViewModel(
                                coordinator: coordinator,
                                monthInvoice: monthInvoice
                            )
                        )
                        
                    case let .summary(communalInvoiceLists):
                        SummaryView(
                            viewModel: SummaryViewModel(
                                coordinator: coordinator,
                                communalInvoiceLists: communalInvoiceLists
                            )
                        )
                    }
                }
                .sheet(
                    item: $coordinator.presentedSheet,
                    onDismiss: {
                        coordinator.onDismiss?(
                            coordinator.lastPresentedSheet
                        )
                    }
                ) { sheet in
                    switch sheet {
                    case .selectPriceType:
                        EmptyView()
                    }
                }
                .alert(
                    coordinator.presentedAlert?.title ?? "Unknown title",
                    isPresented: coordinator.isPresentedAlert,
                ) {
                    if let actions = coordinator.presentedAlert?.actions {
                        ForEach(actions) { action in
                            Button(
                                action.title,
                                role: action.role,
                                action: action.action
                            )
                        }
                    }
                } message: {
                    if let message = coordinator.presentedAlert?.message {
                        Text(message)
                    }
                }
        }
    }
}
