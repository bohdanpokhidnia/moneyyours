//
//  SharedKeys.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.07.2024.
//

import Foundation

extension URL {
    static var addresses: URL {
        URL.temporaryDirectory.appendingPathComponent("addresses.json")
    }
}
