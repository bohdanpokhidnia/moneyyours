//
//  CommunalInvoiceType.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 19.06.2024.
//

import SwiftUI
import SharingGRDB

enum CommunalInvoiceType: Int, Identifiable, FallbackCase, CaseIterable, QueryBindable {
    var id: Int { rawValue }
    static var fallbackCase: CommunalInvoiceType { .unknown }
    
    static var allCases: [CommunalInvoiceType] {
        [
            .electricity,
            .water,
            .heating,
            .gas,
            .gasDelivery,
            .garbageDisposal
        ]
    }
    
    case electricity
    case water
    case heating
    case gas
    case gasDelivery
    case garbageDisposal
    case unknown
    
    var name: String {
        switch self {
        case .electricity: "Electricity"
        case .water: "Water"
        case .heating: "Heating"
        case .gas: "Gas"
        case .gasDelivery: "Gas Delivery"
        case .garbageDisposal: "Garbage Disposal"
        case .unknown: "Unknown"
        }
    }
    
    var emoji: String {
        switch self {
        case .electricity: "⚡️"
        case .water: "💧"
        case .heating: "🌡️"
        case .gas: "🔥"
        case .gasDelivery: "🚚"
        case .garbageDisposal: "🗑️"
        case .unknown: "⚙️"
        }
    }
    
    var emojiBackground: Color {
        switch self {
        case .electricity: .rubberDuckyYellow
        case .water: .artyClickSkyBlue
        case .heating: .artyClickWarmRed
        case .gas: .tomato
        case .gasDelivery: .yellowGreen
        case .garbageDisposal: .slateGrey
        case .unknown: .slateGrey
        }
    }
}
