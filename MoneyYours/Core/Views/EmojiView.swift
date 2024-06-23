//
//  EmojiView.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 23.06.2024.
//

import SwiftUI

struct EmojiView: View {
    let emoji: String
    var emojiFontSize: CGFloat = 20
    let emojiBackground: Color
    var size = CGSize(width: 48, height: 48)
    
    var body: some View {
        ZStack {
            Circle()
                .fill(emojiBackground.gradient)
            
            Text(emoji)
                .font(.system(size: emojiFontSize))
        }
        .frame(width: size.width, height: size.height)
    }
}

#Preview("EmojiView", traits: .sizeThatFitsLayout) {
    EmojiView(
        emoji: "⚙️",
        emojiBackground: .slateGrey
    )
}
