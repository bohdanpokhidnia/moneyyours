//
//  Coordinator.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2025.
//

import Foundation

final class Coordinator: ObservableObject {
    @Published var path: [Screen] = []
    
    func push(screen: Screen) {
        path.append(screen)
    }
    
    func dismiss() {
        guard !path.isEmpty else {
            return
        }
        
        path.removeLast()
    }
    
    func toRoot() {
        path.removeAll()
    }
}

extension Coordinator {
    static let preview = Coordinator()
}
