//
//  Price.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.12.2024.
//

import Foundation
import SwiftUI
import SharingGRDB

@Table
struct Price: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var value: Double?
    var count: Int?
    var secondValue: Double?
    var secondCount: Int?
    
    init(
        id: UUID,
        value: Double,
        count: Int,
        secondValue: Double?,
        secondCount: Int?
    ) {
        self.id = id
        self.value = value
        self.count = count
        self.secondValue = secondValue
        self.secondCount = secondCount
    }
    
    static func single(
        id: UUID,
        value: Double
    ) -> Price {
        Price(
            id: id,
            value: value,
            count: 1,
            secondValue: nil,
            secondCount: nil
        )
    }
    
    static func row(
        id: UUID,
        value: Double,
        count: Int
    ) -> Price {
        Price(
            id: id,
            value: value,
            count: count,
            secondValue: nil,
            secondCount: nil
        )
    }
}

// MARK: - Computed Properties

extension Price {
   
}

extension Binding where Value == Price {
    mutating func update(price: Price) {
        wrappedValue.value = price.value
        wrappedValue.count = price.count
        wrappedValue.secondValue = price.secondValue
        wrappedValue.secondCount = price.secondCount
    }
}
