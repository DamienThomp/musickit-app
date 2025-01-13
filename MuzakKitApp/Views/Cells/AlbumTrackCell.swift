//
//  AlbumTrackCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-31.
//

import SwiftUI
import MusicKit

struct AlbumTrackCell<Content: View>: View {

    let track: Track

    @ViewBuilder let menuContent: Content

    var body: some View {

        HStack(spacing: 4) {

            HStack {

                if let trackNumber = track.trackNumber {
                    Text(trackNumber, format: .number)
                        .foregroundStyle(.secondary)
                        .frame(minWidth: 20)
                } else {
                    Image(systemName: "minus")
                }

                Text(track.title)
                    .font(.callout)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }

            Menu {
                menuContent
            } label: {
                Image(systemName: "ellipsis")
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal)
                    .foregroundStyle(.pink)
            }.highPriorityGesture(TapGesture())
        }.contentShape(Rectangle())
    }
}

#Preview {
    if let tracks = albumTracksMock,
       let track = tracks.first {
        List {
            AlbumTrackCell(track: track) {
                Button {} label: {
                    Label("Add to Playlist", systemImage: "music.note.list")
                }
            }
            .onTapGesture {
                print("tapped")
            }
        }.listStyle(.plain)
    }
}
