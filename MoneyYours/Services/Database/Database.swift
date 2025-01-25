//
//  Database.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 10.01.2025.
//

import Foundation

protocol Database<T> {
    associatedtype T
    
    func create(_ item: T) throws(DatabaseError)
    func create(_ items: [T]) throws(DatabaseError)
    func read(predicate: Predicate<T>?, sortDescriptors: SortDescriptor<T>...) throws(DatabaseError) -> [T]
    func update(_ item: T) throws(DatabaseError)
    func delete(_ item: T) throws(DatabaseError)
    func delete(_ items: [T]) throws(DatabaseError)
}
