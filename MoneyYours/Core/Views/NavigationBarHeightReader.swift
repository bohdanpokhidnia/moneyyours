//
//  NavigationBarHeightReader.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 20.07.2024.
//

import SwiftUI

struct NavigationBarHeightReader: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var navigationBarHeight: Binding<CGFloat>
        
        init(navigationBarHeight: Binding<CGFloat>) {
            self.navigationBarHeight = navigationBarHeight
        }
    }
    
    @Binding var navigationBarHeight: CGFloat
    
    // MARK: - UIViewControllerRepresentable

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        DispatchQueue.main.async {
            guard let navigationController = viewController.navigationController else {
                return
            }
            let height = navigationController.navigationBar.frame.height
            context.coordinator.navigationBarHeight.wrappedValue = height
        }
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(navigationBarHeight: $navigationBarHeight)
    }
}
