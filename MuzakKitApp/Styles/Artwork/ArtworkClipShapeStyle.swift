//
//  ArtworkClipShapeStyle.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-20.
//

import SwiftUI

struct ArtworkClipShapeStyle: ViewModifier {

    enum CornerRadius {

        case large
        case medium
        case small
        case custom(_ size: CGFloat)

        var value: CGFloat {
            
            switch self {
                case .large: 12
                case .medium: 8
                case .small: 6
                case .custom(let radius): radius
            }
        }
    }

    let radius: CornerRadius

    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: radius.value))
    }
}
