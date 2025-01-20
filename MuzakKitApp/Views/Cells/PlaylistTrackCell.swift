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

                Text(track.title)
                    .lineLimit(1)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
