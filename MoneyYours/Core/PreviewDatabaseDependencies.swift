//
//  PreviewDatabaseDependencies.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 22.08.2025.
//

import SharingGRDB
import SwiftUI

struct PreviewDatabaseDependencies<Content: View>: View {
    var content: () -> Content
    
    init(content: @escaping () -> Content) {
        self.content = content
        
        let _ = prepareDependencies {
            let databaseQueue = try! DatabaseQueue(path: mockDBURL().path)
            try! createPriceTable(for: databaseQueue)
            try! createAddressTable(for: databaseQueue)
            try! createMonthInvoicesTable(for: databaseQueue)
            try! createCommunalInvoiceTable(for: databaseQueue)
            $0.defaultDatabase = databaseQueue
        }
    }
    
    var body: some View {
        content()
    }
}
