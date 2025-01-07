//
//  Text+Extensions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-06.
//

import SwiftUI

extension Text {

    func textStyle<T: ViewModifier>(_ style: T) -> some View {
        ModifiedContent(content: self, modifier: style)
    }

    func sectionHeader() -> some View {
        modifier(SectionHeaderStyle())
    }

    func sectionSubtitle() -> some View {
        modifier(SectionSubtitleStyle())
    }
}
