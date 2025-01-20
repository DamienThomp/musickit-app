//
//  HorizontalItems.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-17.
//

import SwiftUI

struct HorizontalItems: ViewModifier {

    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: 18, leading: 0, bottom: 14, trailing: 0))
    }
}
