//
//  AddressSettingsView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 06.07.2024.
//

import SwiftUI

struct AddressSettingsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Settings")
                .font(.system(size: 28, weight: .bold))
                .padding(.top, 12)
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    EmojiView(
                        emoji: "📁",
                        emojiBackground: .rubberDuckyYellow
                    )
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Address name")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color(hex: "#9A9A9A"))
                        
                        Text("Address name")
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundStyle(.primaryText)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.top, 24)
            
            Button("Remove address") {
                
            }
            .buttonStyle(SystemImageButtonStyle(imageSystemName: "trash"))
            .padding(.top, 16)
            .tint(.beanRed)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .background(.appBackground)
    }
}

#Preview {
    NavigationStack {
        AddressSettingsView()
    }
}
