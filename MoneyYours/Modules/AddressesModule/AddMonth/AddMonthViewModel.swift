//
//  AddMonthViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import SwiftUI
import SharingGRDB

final class AddMonthViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    private var addressId: Address.ID
    
    @Dependency(\.dateService) private var dateService
    @Dependency(\.defaultDatabase) private var database
    @Published private(set) var months: [Month] = []
    
    init(coordinator: Coordinator, addressId: Address.ID) {
        self.coordinator = coordinator
        self.addressId = addressId
    }
    
    func onAppear() {
        fetchMonths()
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func select(month: Month) {
        save(month: month)
    }
}

private extension AddMonthViewModel {
    func fetchMonths() {
        do throws(DateServiceError) {
            months = try dateService.sortedMonthAtCurrent(.current, .now)
        } catch {
            print("[dev] Failed fetch months: \(error)")
        }
    }
    
    func save(month: Month) {
        let year = dateService.currentYear(.current, .now)
        let monthInvoice = MonthInvoice(
            id: UUID(),
            addressId: addressId,
            year: year,
            month: month
        )
        
        do {
            try database.write { db in
                try MonthInvoice
                    .insert { monthInvoice }
                    .execute(db)
            }
            
            coordinator.dismiss()
        } catch {
            print("[dev] Failed to save month invoice: \(error)")
        }
    }
}
