//
//  View.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import SwiftUI

extension View {
    var safeArea: UIEdgeInsets {
        guard let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
    
    func setupNavigationTransparent() -> some View {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        return self
    }
}
