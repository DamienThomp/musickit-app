//
//  Color+Extensions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI

public extension Color {

    static var randomColor: Color {
        let colors: [Color] = [
            .red,
            .green,
            .blue,
            .teal,
            .cyan,
            .orange,
            .pink,
            .purple,
            .indigo,
            .mint
        ]

        if let color = colors.randomElement() {
            return color
        } else {
            return Color.random()
        }
    }

    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
