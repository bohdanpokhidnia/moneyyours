//
//  PriceInputFormatStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 01.02.2025.
//

import SwiftUI

struct PriceInputFormatStyle: FormatStyle {
    func format(_ value: String) -> String {
        var filtered = value.replacingOccurrences(of: ",", with: ".")
        
        filtered = filtered.filter { "0123456789.".contains($0) }
        
        if filtered.contains("..") {
            filtered = filtered.replacingOccurrences(of: "..", with: ".")
        }
        
        let parts = filtered.split(separator: ".")
        if parts.count > 2 {
            filtered = parts.prefix(2).joined(separator: ".")
        }
        
        if filtered == "." {
            return "0."
        }
        
        if let dotIndex = filtered.firstIndex(of: ".") {
            let decimalPart = filtered[dotIndex...].dropFirst()
            if decimalPart.count > 2 {
                filtered = String(filtered.prefix(filtered.distance(from: filtered.startIndex, to: dotIndex) + 3))
            }
        }
        
        if filtered.count == 2, String(filtered.prefix(1)) == "0" {
            filtered = String(filtered.suffix(1))
        }
        
        if filtered.isEmpty {
            return "0"
        }
        
        return filtered
    }
}
