//
//  Text+Extensions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-06.
//

import SwiftUI

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
