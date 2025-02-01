//
//  FormatStyle.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 01.02.2025.
//

import SwiftUI

extension FormatStyle where Self == UkrainianHryvniaFormatStyle {
    static var ukrainianHryvnia: UkrainianHryvniaFormatStyle {
        UkrainianHryvniaFormatStyle()
    }
}

extension FormatStyle where Self == PriceInputFormatStyle {
    static var priceInput: PriceInputFormatStyle {
        PriceInputFormatStyle()
    }
}
