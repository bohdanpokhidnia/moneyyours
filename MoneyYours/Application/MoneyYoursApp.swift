//
//  MoneyYoursApp.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import SharingGRDB

fileprivate func dbURL() -> URL {
    let fileManager = FileManager.default
    let folder = try! fileManager.url(
        for: .applicationSupportDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
    )
    return folder.appendingPathComponent("money.yours.db.sqlite")
}

func mockDBURL() -> URL {
    let fileManager = FileManager.default
    let folder = try! fileManager.url(
        for: .applicationSupportDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
    )
    return folder.appendingPathComponent("mock.money.yours.db.sqlite")
}

enum Table: String {
    case addresses
    case communalInvoices
    case prices
}

func createAddressTable(for queue: DatabaseQueue) throws {
    try queue.write { db in
        try db.create(table: Table.addresses.rawValue, ifNotExists: true) { t in
            t.column("id", .text).primaryKey()
            t.column("name", .text).notNull()
            t.column("state", .text).notNull()
        }
    }
}

func createCommunalInvoiceTable(for queue: DatabaseQueue) throws {
    try queue.write { db in
        try db.create(table: Table.communalInvoices.rawValue, ifNotExists: true) { t in
            t.column("id", .text).primaryKey()
            t.column("addressId", .text)
                .notNull()
                .references(Table.addresses.rawValue, onDelete: .cascade)
            t.column("year", .integer).notNull()
            t.column("month", .text).notNull()
            t.column("type", .text).notNull()
            t.column("priceId", .text)
                .notNull()
                .references(Table.prices.rawValue, onDelete: .setNull)
        }
    }
}

func createPriceTable(for queue: DatabaseQueue) throws {
    try queue.write { db in
        try db.create(table: Table.prices.rawValue, ifNotExists: true) { t in
            t.column("id", .text).primaryKey()
            t.column("kind", .text).notNull()
            t.column("value", .double)
            t.column("count", .integer)
        }
    }
}

@main
struct MoneyYoursApp: App {
    @ObservedObject private var coordinator = Coordinator()
    
    init() {
        prepareDependencies {
            let databaseQueue = try! DatabaseQueue(path: dbURL().path)
            try! createPriceTable(for: databaseQueue)
            try! createAddressTable(for: databaseQueue)
            try! createCommunalInvoiceTable(for: databaseQueue)
            
            $0.defaultDatabase = databaseQueue
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AddressesView(viewModel: AddressesViewModel(coordinator: coordinator))
                .setupNavigationTransparent()
        }
    }
}
