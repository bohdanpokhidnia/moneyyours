//
//  AddAddressTests.swift
//  MoneyYoursTests
//
//  Created by Bohdan Pokhidnia on 01.08.2025.
//

import XCTest

@testable import MoneyYours

final class AddAddressTests: XCTestCase {
    let viewModel = AddAddressViewModel1(coordinator: .preview)
    
    func test_updateAddress() {
        XCTAssertEqual(
            viewModel.updateAddress(name: "foo"),
            [
                .setAddress(name: "foo"),
                .setSaveButton(disabled: false)
            ]
        )
    }
    
    func test_updateEmptyAddress() {
        XCTAssertEqual(
            viewModel.updateAddress(name: ""),
            [
                .setAddress(name: ""),
                .setSaveButton(disabled: true)
            ]
        )
    }
    
    func test_sendAddress() {
        XCTAssertEqual(
            viewModel.savingAddress(name: "bazz"),
            [
                .set(loading: true),
                .send(
                    name: "bazz",
                    onSuccess: .dismiss,
                    onFailure: .showFailureToast(text: "Don't save address")
                )
            ]
        )
    }
}
