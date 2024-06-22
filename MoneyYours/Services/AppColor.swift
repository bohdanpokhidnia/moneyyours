//
//  AppColor.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 12.06.2024.
//

import SwiftUI
import ComposableArchitecture

class AppColor {
    @Published var tint: Color = .beanRed
}

extension AppColor: DependencyKey {
    static var liveValue = AppColor()
}

extension DependencyValues {
    var appColor: AppColor {
        get { self[AppColor.self] }
        set { self[AppColor.self] = newValue }
    }
}
