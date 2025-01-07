//
//  AlbumTrackCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-31.
//

import SwiftUI
import MusicKit

struct AlbumTrackCell: View {

    let track: Track

    var body: some View {

        HStack(spacing: 4) {

            if let trackNumber = track.trackNumber {
                Text(trackNumber, format: .number)
                    .foregroundStyle(.secondary)
            } else {
                Image(systemName: "minus")
            }

            Text(track.title)
                .font(.callout)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            Image(systemName: "ellipsis")
                .foregroundStyle(.pink)
        }
    }
}
