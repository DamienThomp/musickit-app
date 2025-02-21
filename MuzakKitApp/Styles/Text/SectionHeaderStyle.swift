//
//  SectionHeaderStyle.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-06.
//

import SwiftUI

struct SectionHeaderStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.system(.title2))
            .fontWeight(.bold)
    }
}

struct SectionSubtitleStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(.caption))
            .foregroundStyle(.secondary)
    }
}
