//
//  InvoicesLoader.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import ComposableArchitecture

struct InvoicesLoader {
    var fetch: () -> [CommunalInvoice]
}

extension InvoicesLoader: DependencyKey {
    static var liveValue = InvoicesLoader {
        [
            CommunalInvoice(
                type: .electricity,
                price: 4.32,
                amount: .zero
            ),
            CommunalInvoice(
                type: .water,
                price: 15.00,
                amount: .zero
            ),
            CommunalInvoice(
                type: .heating,
                price: .zero,
                amount: .zero
            ),
            CommunalInvoice(
                type: .gas,
                price: 7.95,
                amount: .zero
            ),
            CommunalInvoice(
                type: .gasDelivery,
                price: 6.86,
                amount: .zero
            ),
            CommunalInvoice(
                type: .garbageDisposal,
                price: 25.26,
                amount: .zero
            ),
        ]
    }
}

extension DependencyValues {
    var invoicesLoader: InvoicesLoader {
        get { self[InvoicesLoader.self] }
        set { self[InvoicesLoader.self] = newValue }
    }
}
