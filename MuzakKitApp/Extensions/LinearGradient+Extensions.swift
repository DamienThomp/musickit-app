//
//  LinearGradient+Extensions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2026-05-13.
//

import SwiftUI

extension LinearGradient {
    static let albumDetailsGradient = LinearGradient(
            colors: [
                Color(.systemBackground),
                Color(.systemBackground),
                Color(.systemGray6),
                Color(.systemGray6)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
}
