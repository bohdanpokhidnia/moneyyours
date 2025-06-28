//
//  SelectMonthViewModel.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import SwiftUI

final class SelectMonthViewModel: ObservableObject {
    @ObservedObject private var coordinator: Coordinator
    private var selectedMonth: Binding<Month>
    
    let months = Month.allCases
    
    init(coordinator: Coordinator, selectedMonth: Binding<Month>) {
        self.coordinator = coordinator
        self.selectedMonth = selectedMonth
    }
    
    func backButtonTapped() {
        coordinator.dismiss()
    }
    
    func select(month: Month) {
        selectedMonth.wrappedValue = month
        coordinator.dismiss()
    }
}
