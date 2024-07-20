//
//  LightThemeShadow.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI

struct LightThemeShadow: ViewModifier {
    var color: Color = .black.opacity(0.1)
    var radius: CGFloat = 10
    var x: CGFloat = 0
    var y: CGFloat = 8
    
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        if colorScheme == .light {
            content
                .shadow(color: color, radius: radius, x: x, y: y)
        } else {
            content
        }
    }
}

extension View {
    func lightThemeShadow(
        color: Color = .black.opacity(0.1),
        radius: CGFloat = 10,
        x: CGFloat = 0,
        y: CGFloat = 8
    ) -> some View {
        self.modifier(
            LightThemeShadow(
                color: color,
                radius: radius,
                x: x,
                y: y
            )
        )
    }
}
