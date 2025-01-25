//
//  SwiftDatabase.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 14.01.2025.
//

import SwiftData
import Foundation

class SwiftDatabase<T: PersistentModel>: Database {
    private let container: ModelContainer
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    func create(_ item: T) throws(DatabaseError) {
        let context = ModelContext(container)
        context.insert(item)
        
        do {
            try context.save()
        } catch {
            throw .creationFailed(description: "Failed create: \(T.self)")
        }
    }
    
    func create(_ items: [T]) throws(DatabaseError) {
        let context = ModelContext(container)
        
        for item in items {
            context.insert(item)
        }
        
        do {
            try context.save()
        } catch {
            throw .creationFailed(description: "Failed create: \(T.self)")
        }
    }
    
    func read(predicate: Predicate<T>?, sortDescriptors: SortDescriptor<T>...) throws(DatabaseError) -> [T] {
        let context = ModelContext(container)
        let fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortDescriptors)
        
        do {
            let items = try context.fetch(fetchDescriptor)
            return items
        } catch {
            throw .readingFailed(description: "Failed read: \(T.self)")
        }
    }
    
    func update(_ item: T) throws(DatabaseError) {
        let context = ModelContext(container)
        context.insert(item)
        
        do {
            try context.save()
        } catch {
            throw .updateFailed(description: "Failed to save updated: \(T.self)")
        }
    }
    
    func delete(_ item: T) throws(DatabaseError) {
        let context = ModelContext(container)
        let itemId = item.persistentModelID
        
        do {
            try context.delete(
                model: T.self,
                where: #Predicate { item in
                    item.persistentModelID == itemId
                }
            )
            try context.save()
        } catch {
            throw .deletionFailed(description: "Failed delete: \(T.self)")
        }
    }
    
    func delete(_ items: [T]) throws(DatabaseError) {
        let context = ModelContext(container)
        
        do {
            for item in items {
                let itemId = item.persistentModelID
                try context.delete(
                    model: T.self,
                    where: #Predicate { item in
                        item.persistentModelID == itemId
                    }
                )
            }
            
            try context.save()
        } catch {
            throw .deletionFailed(description: "Failed delete: \(T.self)")
        }
    }
}
