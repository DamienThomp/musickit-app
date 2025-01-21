//
//  ArtistItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct ArtistItemCell: View {

    let item: Artist?
    let size: CGFloat

    private var artwork: Artwork? {
        item?.artwork
    }

    private var artistName: String? {
        item?.name
    }

    var body: some View {
        VStack {
            if let artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .clipShape(Circle())
            } else {
                Symbols.artistPlaceholder.image
                        .resizableImage()
                        .padding(36)
                        .foregroundStyle(.pink.opacity(0.6))
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                        .frame(width: size, height: size)
            }

            if let artistName {
                Text(artistName)
            }
        }.frame(maxWidth: size)
    }
}

#Preview {
    ArtistItemCell(item: nil, size: 250)
}
