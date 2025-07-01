//
//  SummaryViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2025.
//

import SwiftUI

final class SummaryViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    let communalInvoiceLists: [CommunalInvoiceList]
    
    var sum: Double {
        communalInvoiceLists.reduce(0) { result, list in
            result + list.price
        }
    }
    
    init(coordinator: Coordinator, communalInvoiceLists: [CommunalInvoiceList]) {
        self.coordinator = coordinator
        self.communalInvoiceLists = communalInvoiceLists
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
}
