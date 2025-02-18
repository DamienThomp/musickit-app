//
//  HapticHelper.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-02-18.
//

import SwiftUI

class HapticHelper {

    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
