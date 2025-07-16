//
//  GradientHeaderConfiguration.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 20.07.2024.
//

import SwiftUI

struct GradientHeaderConfiguration {
    var colors: [Color]
}

extension GradientHeaderConfiguration {
    static let addresses = GradientHeaderConfiguration(colors: [.cerulean, .richElectricBlue, .frenchBlue])
    static let clear = GradientHeaderConfiguration(colors: [])
}
