//
//  AddressFeature.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 15.06.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AddressFeature {
    @ObservableState
    struct State: Equatable {
        var address: Address
        
        var yeas: [Int] {
            Set<Int>(address.communalInvoices.map { $0.year }).map({ $0 })
        }
    }
    
    enum Action: ViewAction {
        case view(View)
        case delegate(Delegate)
        
        enum View {
            case backButtonTapped
            case settingsButtonTapped
            case addInvoiceButtonTapped
        }
        
        @CasePathable
        enum Delegate {
            case settings(address: Address)
            case addInvoice(month: Month)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.monthService) var monthService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.backButtonTapped):
                return .run { _ in
                    await dismiss()
                }
                
            case .view(.settingsButtonTapped):
                return .send(.delegate(.settings(address: state.address)))
                
            case .view(.addInvoiceButtonTapped):
                do throws(MonthServiceError) {
                    let currentMonth = try monthService.month(Calendar.current, Date.now)
                    return .send(.delegate(.addInvoice(month: currentMonth)))
                } catch {
                    print("[dev] \(error)")
                    return .none
                }
                
            case .delegate:
                return .none
            }
        }
    }
}
