//
//  Environment+Extension.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-23.
//

import Foundation
import SwiftUI

extension EnvironmentValues {

    @Entry var debounce: DebounceHelper = DebounceHelper()
    @Entry var haptics: HapticHelper = HapticHelper()
    @Entry var navigationNamespace: Namespace.ID?
}
