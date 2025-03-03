//
//  PlaylistTrackCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-31.
//

import SwiftUI
import MusicKit

struct PlaylistTrackCell<Content: View>: View {

    let track: Track

    @ViewBuilder let menuContent: Content

    var body: some View {

        HStack(spacing: 4) {
            HStack {

                if let artwork = track.artwork {
                    ArtworkImage(artwork, width: 40)
                        .artworkCornerRadius(.medium)
                }

                VStack(spacing: 6) {
                    Text(track.title)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(track.artistName)
                        .font(.caption)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
            }.contentShape(Rectangle())

            Spacer()

            Menu {
                menuContent
            } label: {

                Symbols.ellipsis.image
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal)
                    .foregroundStyle(.pink)
            }
            .highPriorityGesture(TapGesture())
        }
    }
}
