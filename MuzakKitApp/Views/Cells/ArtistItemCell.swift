//
//  ArtistItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct ArtistItemCell: View {

    let item: Artist
    let size: CGFloat

    var body: some View {
        VStack {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .clipShape(Circle())
            } else {
                Rectangle()
                    .fill(LinearGradient(colors: [.pink, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: size, height: size)
                    .clipShape(Circle())

            }
            Text(item.name)
        }.frame(maxWidth: size)
    }
}
