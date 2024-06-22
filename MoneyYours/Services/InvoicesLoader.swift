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
                price: 2.64,
                amount: .zero
            ),
            Invoice(
                type: .water,
                price: .zero,
                amount: .zero
            ),
            Invoice(
                type: .heating,
                price: .zero,
                amount: .zero
            ),
            Invoice(
                type: .gas,
                price: .zero,
                amount: .zero
            ),
            Invoice(
                type: .gasDelivery,
                price: 6.86,
                amount: .zero
            ),
            Invoice(
                type: .garbageDisposal,
                price: 24.0,
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
