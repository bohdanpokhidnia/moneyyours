//
//  Coordinator.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 27.06.2025.
//

import SwiftUI

final class Coordinator: ObservableObject {
    @Published var path: [Screen] = []
    @Published var presentedSheet: Sheet?
    @Published var presentedAlert: Alert?
    @Published var invoiceName: String = "Name"
    @Published var communalInvoiceType: CommunalInvoiceType = .notSelected
    @Published var month: Month = .unknown
    @Published var price: Price = .single(id: UUID(), value: .zero)
    private(set) var lastPresentedSheet: Sheet?
    
    var isPresentedAlert: Binding<Bool> {
        Binding(
            get: { [weak self] in
                self?.presentedAlert != nil
            },
            set: { [weak self] newValue in
                guard !newValue else { return }
                self?.presentedAlert = nil
            }
        )
    }
    
    var onDismiss: ((Sheet?) -> Void)?
    
    func push(screen: Screen) {
        path.append(screen)
    }
    
    func present(sheet: Sheet) {
        presentedSheet = sheet
        lastPresentedSheet = sheet
    }
    
    func present(alert: Alert) {
        presentedAlert = alert
    }
    
    func dismiss() {
        if presentedSheet != nil {
            presentedSheet = nil
        } else {
            guard !path.isEmpty else {
                return
            }
            
            path.removeLast()
        }
    }
    
    func toRoot() {
        path.removeAll()
    }
}

extension Coordinator {
    static let preview = Coordinator()
}
