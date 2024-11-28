//
//  AddressSettingsFeature+AlertState.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 28.11.2024.
//

import ComposableArchitecture

extension AlertState where Action == AddressSettingsFeature.RemoveAlert {
    static func remove(addressName: String) -> AlertState {
        AlertState(
            title: {
                TextState("Do yo want remove?")
            },
            actions: {
                ButtonState(role: .cancel, action: .cancel) {
                    TextState("Cancel")
                }
                
                ButtonState(role: .destructive, action: .confirm) {
                    TextState("Confirm")
                }
            },
            message: {
                TextState(addressName)
            }
        )
    }
}

extension AlertState where Action == AddressSettingsFeature.ArchiveAlert {
    static func archive(addressName: String) -> AlertState {
        AlertState(
            title: {
                TextState("Do yo want move to archive?")
            },
            actions: {
                ButtonState(action: .cancel) {
                    TextState("Cancel")
                }
                
                ButtonState(action: .confirm) {
                    TextState("Confirm")
                }
            },
            message: {
                TextState(addressName)
            }
        )
    }
}
