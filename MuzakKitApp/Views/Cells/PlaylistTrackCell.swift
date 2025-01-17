//
//  PlaylistTrackCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-31.
//

import SwiftUI
import MusicKit

struct PlaylistTrackCell: View {

    let track: Track

    var body: some View {

        HStack(spacing: 4) {

            if let artwork = track.artwork {
                ArtworkImage(artwork, width: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Text(track.title)
                .lineLimit(1)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            Symbols.ellipsis.image.foregroundStyle(.pink)
        }
    }
}
