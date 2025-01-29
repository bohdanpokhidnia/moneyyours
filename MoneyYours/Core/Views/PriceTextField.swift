//
//  PriceTextField.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 29.01.2025.
//

import SwiftUI

struct PriceTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField(
            "",
            text: $text
        )
        .multilineTextAlignment(.center)
        .onChange(of: text) { _, newValue in
            text = formatPriceInput(newValue)
        }
    }
    
    private func formatPriceInput(_ input: String) -> String {
        var filtered = input.replacingOccurrences(of: ",", with: ".") // Заміна , на .
        
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

#Preview {
    @Previewable @State var text: String = "0.00"
    
    PriceTextField(text: $text)
}
