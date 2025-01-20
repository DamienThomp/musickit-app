//
//  AlbumItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct AlbumItemCell: View {
    
    let item: Album
    let size: CGFloat

    var body: some View {
        VStack(alignment: .leading) {

            if let artwork = item.artwork {

                ArtworkImage(artwork, width: size, height: size)
                    .artworkCornerRadius(.medium)
            } else {

                Image(systemName: "music.mic")
                    .resizableImage()
                    .foregroundStyle(.pink, .black)
                    .background(.secondary)
                    .artworkCornerRadius(.medium)
                    .frame(width: size, height: size)
            }

            Text(item.title)
                .font(.system(.subheadline))
                .lineLimit(1)


            Text(item.artistName)
                .font(.system(.caption2))
                .foregroundStyle(.secondary)
                .lineLimit(1)

        }.frame(maxWidth: size)
    }
}
