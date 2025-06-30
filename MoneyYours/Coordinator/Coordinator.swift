//
//  Coordinator.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2025.
//

import Foundation

final class Coordinator: ObservableObject {
    @Published var path: [Screen] = []
    @Published var presentedSheet: Sheet?
    private(set) var lastPresentedSheet: Sheet?
    
    var onDismiss: ((Sheet?) -> Void)?
    
    func push(screen: Screen) {
        path.append(screen)
    }
    
    func present(sheet: Sheet) {
        presentedSheet = sheet
        lastPresentedSheet = sheet
    }
    
    func dismiss() {
        if presentedSheet != nil {
            presentedSheet = nil
        } else {
            guard !path.isEmpty else {
                return
            }
            
            path.removeLast()
        }
    }
    
    func toRoot() {
        path.removeAll()
    }
}

extension Coordinator {
    static let preview = Coordinator()
}
