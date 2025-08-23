//
//  PreviewCoordinatorNavigationStack.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.08.2025.
//

import SwiftUI

struct PreviewCoordinatorNavigationStack<Content: View>: View {
    @ObservedObject var coordinator: Coordinator
    var content: () -> Content
    
    init(
        coordinator: Coordinator = .preview,
        content: @escaping () -> Content
    ) {
        self.coordinator = coordinator
        self.content = content
    }
    
    var body: some View {
        CoordinatorNavigationStack(coordinator: coordinator) {
            content()
        }
    }
}
