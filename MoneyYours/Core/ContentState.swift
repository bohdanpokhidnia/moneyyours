//
//  ContentState.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 08.12.2024.
//

import SwiftUI

enum ContentState<Content: Equatable, Empty: Equatable>: Equatable {
    case content(content: Content)
    case empty(state: Empty)
    
    var isEmptyState: Bool {
        get {
            switch self {
            case .content: false
            case .empty: true
            }
        }
        set {
            
        }
    }
    
    var emptyState: Binding<Empty?> {
        Binding(
            get: {
                guard case let .empty(state) = self else {
                    return nil
                }
                return state
            }
        )
    }
}
