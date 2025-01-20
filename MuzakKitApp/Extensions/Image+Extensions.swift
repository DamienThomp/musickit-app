//
//  Image+Extensions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-20.
//

import SwiftUI

extension Image {

    func resizableImage(_ contentMode: ContentMode = .fit) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}
