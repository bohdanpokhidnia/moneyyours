//
//  Alert.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 19.07.2025.
//

import SwiftUI

struct AlertAction: Identifiable {
    let id = UUID()
    let title: String
    let role: ButtonRole?
    let action: () -> Void
    
    init(title: String,
         role: ButtonRole? = nil,
         action: @escaping () -> Void) {
        self.title = title
        self.role = role
        self.action = action
    }
}

struct Alert {
    var title: String
    var message: String?
    var actions: [AlertAction]
    
    init(
        title: String,
        message: String? = nil,
        @AlertActionsBuilder actions: () -> [AlertAction]
    ) {
        self.title = title
        self.message = message
        self.actions = actions()
    }
}

@resultBuilder
struct AlertActionsBuilder {
    // Simple use
    static func buildBlock(_ components: [AlertAction]...) -> [AlertAction] {
        components.flatMap { $0 }
    }
    
    static func buildExpression(_ expression: AlertAction) -> [AlertAction] {
        [expression]
    }
    
    // if
    static func buildOptional(_ component: [AlertAction]?) -> [AlertAction] {
        component ?? []
    }
    
    // if/else
    static func buildEither(first component: [AlertAction]) -> [AlertAction] { component }
    static func buildEither(second component: [AlertAction]) -> [AlertAction] { component }
    
    // for
    static func buildArray(_ components: [[AlertAction]]) -> [AlertAction] {
        components.flatMap { $0 }
    }
    
    // Nothing
    static func buildFinalResult(_ component: [AlertAction]) -> [AlertAction] { component }
    
    ///    {
    ///        AlertAction(...),
    ///        AlertAction(...)
    ///    }
    static func buildExpression(_ expression: (AlertAction, AlertAction)) -> [AlertAction] {
        [expression.0, expression.1]
    }
    
    static func buildExpression(_ expression: (AlertAction, AlertAction, AlertAction)) -> [AlertAction] {
        [expression.0, expression.1, expression.2]
    }
    
    static func buildExpression(_ expression: (AlertAction, AlertAction, AlertAction, AlertAction)) -> [AlertAction] {
        [expression.0, expression.1, expression.2, expression.3]
    }
    
    static func buildExpression(_ expression: (AlertAction, AlertAction, AlertAction, AlertAction, AlertAction)) -> [AlertAction] {
        [expression.0, expression.1, expression.2, expression.3, expression.4]
    }
}
