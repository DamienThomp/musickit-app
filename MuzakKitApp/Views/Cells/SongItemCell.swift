//
//  SongItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-19.
//

import SwiftUI
import MusicKit

struct SongItemCell: View {

    let item: Song
    let width: CGFloat

    var body: some View {

        HStack {

            if let artwork = item.artwork {
                ArtworkImage(artwork, width: 50)
                    .cornerRadius(12)
            }

            VStack(alignment: .leading) {
                Text(item.title)
                Text(item.artistName)
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                Divider()
            }
            .lineLimit(1)
            .multilineTextAlignment(.leading)

            Spacer()
        }
        .frame(width: width)
    }
}
