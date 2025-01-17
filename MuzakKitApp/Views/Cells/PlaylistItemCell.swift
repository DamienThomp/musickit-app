//
//  PlaylistItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct PlaylistItemCell: View {

    let item: Playlist
    let size: CGFloat

    var body: some View {

        VStack(alignment: .leading) {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Text(item.name)
                .font(.system(.subheadline))
                .lineLimit(1)

        }.frame(maxWidth: size)
    }
}
