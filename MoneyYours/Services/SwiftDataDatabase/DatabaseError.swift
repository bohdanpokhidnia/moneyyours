//
//  DatabaseError.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 14.01.2025.
//

import Foundation

enum DatabaseError: Error {
    case creationFailed(description: String)
    case readingFailed(description: String)
    case updateFailed(description: String)
    case deletionFailed(description: String)
    
    var description: String {
        switch self {
        case let .creationFailed(description): description
        case let .readingFailed(description): description
        case let .updateFailed(description): description
        case let .deletionFailed(description): description
        }
    }
}
