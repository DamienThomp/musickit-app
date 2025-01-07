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
                    .cornerRadius(8)
            } else {

                Image(systemName: "music.mic")
                    .resizable()
                    .foregroundStyle(.pink, .black)
                    .background(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
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
