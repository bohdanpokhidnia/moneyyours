//
//  CommunalInvoiceList.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 30.06.2025.
//

import Foundation

struct CommunalInvoiceList: Identifiable, Hashable {
    var id: UUID { invoice.id }
    
    let title: String
    let invoice: CommunalInvoice
    let price: Double
}
