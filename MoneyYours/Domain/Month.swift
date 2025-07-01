//
//  Month.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2024.
//

import SwiftUI
import SharingGRDB

enum Month: Int, Identifiable, FallbackCase, CaseIterable, EmojiAvailable, QueryBindable {
    var id: Int { rawValue }
    static var fallbackCase: Month { .unknown }
    static var allCases: [Month] {
        [
            .january,
            .february,
            .march,
            .april,
            .may,
            .june,
            .july,
            .august,
            .september,
            .october,
            .november,
            .december
        ]
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    case unknown
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    
    var name: String {
        switch self {
        case .unknown: "Unknown"
        case .january: "January"
        case .february: "February"
        case .march: "March"
        case .april: "April"
        case .may: "May"
        case .june: "June"
        case .july: "July"
        case .august: "August"
        case .september: "September"
        case .october: "October"
        case .november: "November"
        case .december: "December"
        }
    }
    
    var emoji: String {
        switch self {
        case .unknown: "🥲"
        case .january: "🥂"
        case .february: "❤️"
        case .march: "🍀"
        case .april: "🐣"
        case .may: "🌸"
        case .june: "☀️"
        case .july: "🎆"
        case .august: "🏖️"
        case .september: "🍁"
        case .october: "🎃"
        case .november: "🦃"
        case .december: "🎄"
        }
    }
    
    var color: Color {
        switch self {
        case .unknown: Color.gray
        case .january: Color(hex: "#ADD8E6")
        case .february: Color(hex: "#FFC0CB")
        case .march: Color(hex: "#98FB98")
        case .april: Color(hex: "#FFD700")
        case .may: Color(hex: "#FF69B4")
        case .june: Color(hex: "#FFD700")
        case .july: Color(hex: "#FF4500")
        case .august: Color(hex: "#87CEFA")
        case .september: Color(hex: "#FFA07A")
        case .october: Color(hex: "#FF8C00")
        case .november: Color(hex: "#8B4513")
        case .december: Color(hex: "#008000")
        }
    }
}
