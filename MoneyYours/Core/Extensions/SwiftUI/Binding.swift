//
//  Binding.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 08.12.2024.
//

import SwiftUI

extension Binding {
    @preconcurrency public init(get: @escaping @isolated(any) @Sendable () -> Value) {
        self.init(get: get, set: { _ in })
    }
}
