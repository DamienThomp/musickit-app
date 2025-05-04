//
//  AlbumItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct AlbumItemCell: View {

    let item: Album?
    let size: CGFloat

    private var title: String {
        item?.title ?? "Album Title"
    }

    private var subtitle: String {
        item?.artistName ?? "Artist Name"
    }

    private var artwork: Artwork? {
        item?.artwork
    }

    private var itemWidth: CGFloat {

        return size > 0 ? size : 0.0
    }

    var body: some View {

        VStack(alignment: .leading) {

            if let artwork {

                ArtworkImage(artwork, width: itemWidth, height: itemWidth)
                    .artworkCornerRadius(.medium)
            } else {

            Symbols.albumPlaceholder.image
                    .resizableImage()
                    .padding(36)
                    .foregroundStyle(.pink.opacity(0.6))
                    .background(Color(.systemGray5))
                    .artworkCornerRadius(.medium)
                    .frame(width: itemWidth, height: itemWidth)
           }

            Text(title)
                .font(.system(.subheadline))
                .lineLimit(1)

            Text(subtitle)
                .font(.system(.caption2))
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: itemWidth)
    }
}

#Preview {
    AlbumItemCell(item: nil, size: 250)
}
