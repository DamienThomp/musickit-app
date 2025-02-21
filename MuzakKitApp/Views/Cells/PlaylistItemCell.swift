//
//  PlaylistItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct PlaylistItemCell: View {

    let item: Playlist?
    let size: CGFloat

    private var title: String {
        item?.name ?? "Playlist"
    }

    private var artwork: Artwork? {
        item?.artwork
    }

    var body: some View {

        VStack(alignment: .leading) {
            if let artwork {

                ArtworkImage(artwork, width: size, height: size)
                    .artworkCornerRadius(.medium)
            } else {
                Symbols.playlistPlaceholder.image
                        .resizableImage()
                        .padding(36)
                        .foregroundStyle(.pink.opacity(0.6))
                        .background(Color(.systemGray5))
                        .artworkCornerRadius(.medium)
                        .frame(width: size, height: size)
            }

            Text(title)
                .font(.system(.subheadline))
                .lineLimit(1)
        }.frame(maxWidth: size)
    }
}

#Preview {
    PlaylistItemCell(item: nil, size: 250)
}
