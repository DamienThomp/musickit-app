//
//  PlayerMatchedGeometry.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-15.
//

import Foundation
import SwiftUI

enum PlayerMatchedGeometry: String {

    case coverImage
    case title
    case subtitle
    case primaryAction
    case secondaryAction
    case background

    var name: String {
        self.rawValue
    }

    static var animation: Animation {
       .interpolatingSpring(duration: 0.4, bounce: 0.2)
    }
}
