//
//  ReceiptShapeWithWaves.swift
//  MoneyYours
//
//  Created by Bohdan Pokhidnia on 16.07.2025.
//

import SwiftUI

struct ReceiptShapeWithWaves: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let waveRadius: CGFloat = 8
        let waveDiameter = waveRadius * 2.5
        let numberOfWaves = Int(rect.width / waveDiameter) + 2
        let adjustedWidth = CGFloat(numberOfWaves) * waveDiameter
        let startX = (rect.width - adjustedWidth) / 2

        path.move(to: CGPoint(x: 0, y: waveRadius))
        for i in 0..<numberOfWaves {
            let x = startX + CGFloat(i) * waveDiameter
            path.addArc(
                center: CGPoint(x: x + waveRadius, y: 0),
                radius: waveRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(0),
                clockwise: true
            )
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height - waveRadius))
        for i in (0..<numberOfWaves).reversed() {
            let x = startX + CGFloat(i) * waveDiameter
            path.addArc(
                center: CGPoint(x: x + waveRadius, y: rect.height),
                radius: waveRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(180),
                clockwise: true
            )
        }

        path.addLine(to: CGPoint(x: 0, y: waveRadius))
        path.closeSubpath()
        return path
    }
}
