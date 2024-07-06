//
//  InvoicesLoader.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.06.2024.
//

import ComposableArchitecture

struct InvoicesLoader {
    var fetch: () -> [Invoice]
}

extension InvoicesLoader: DependencyKey {
    static var liveValue = InvoicesLoader {
        [
            Invoice(
                type: .electricity,
                price: 4.32,
                amount: .zero
            ),
            Invoice(
                type: .water,
                price: 15.00,
                amount: .zero
            ),
            Invoice(
                type: .heating,
                price: .zero,
                amount: .zero
            ),
            Invoice(
                type: .gas,
                price: 7.95,
                amount: .zero
            ),
            Invoice(
                type: .gasDelivery,
                price: 6.86,
                amount: .zero
            ),
            Invoice(
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
