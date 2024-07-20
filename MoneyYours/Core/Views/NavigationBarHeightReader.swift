//
//  NavigationBarHeightReader.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 20.07.2024.
//

import SwiftUI

struct NavigationBarHeightReader: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var fullNavigationBarHeight: Binding<CGFloat>
        
        init(fullNavigationBarHeight: Binding<CGFloat>) {
            self.fullNavigationBarHeight = fullNavigationBarHeight
        }
    }
    
    @Binding var fullNavigationBarHeight: CGFloat
    
    // MARK: - UIViewControllerRepresentable

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        DispatchQueue.main.async {
            guard let navigationController = viewController.navigationController else {
                return
            }
            let fullHeight = navigationController.navigationBar.frame.height + safeArea.top
            context.coordinator.fullNavigationBarHeight.wrappedValue = fullHeight
        }
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(fullNavigationBarHeight: $fullNavigationBarHeight)
    }
}
