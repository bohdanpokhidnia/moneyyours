//
//  SelectMonthFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct SelectMonthFeature {
    @ObservableState
    struct State: Equatable {
        var selectedMonth: Shared<Month>
        var months: [Month] = []
    }
    
    enum Action {
        case onAppear
        case backButtonTapped
        case select(month: Month)
        case delegate(Delegate)
    }
    
    enum Delegate {
        case pop
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.monthService) var monthService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                do throws(MonthServiceError) {
                    let months = try monthService.sortedMonthAtCurrent(Calendar.current, Date.now)
                    state.months = months
                } catch {
                    print("[dev] \(error)")
                }
                return .none
                
            case .backButtonTapped:
                return .run { _ in
                    await dismiss()
                }
                
            case let .select(month):
                state.selectedMonth.wrappedValue = month
                return .send(.delegate(.pop))
                
            case .delegate:
                return .none
            }
        }
    }
}
