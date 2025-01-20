//
//  View + Extensions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-08.
//

import SwiftUI

extension View {
    
    func plainHeaderStyle() -> some View {
        modifier(DetailPlainSection())
    }

    func horizontalDefaultInsets() -> some View {
        modifier(HorizontalItems())
    }

    func artworkCornerRadius(_ radius: ArtworkClipShapeStyle.CornerRadius) -> some View {
        modifier(ArtworkClipShapeStyle(radius: radius))
    }
}
