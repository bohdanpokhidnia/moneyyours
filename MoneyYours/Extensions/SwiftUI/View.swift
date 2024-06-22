//
//  View.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI

extension View {
    func updateBackButton(color: Color) -> some View {
        let image = UIImage(systemName: "arrow.backward")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(UIColor(color))
        
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        return self
    }
}
