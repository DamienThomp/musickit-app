//
//  MenuItems.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-17.
//

import SwiftUI
import MusicKit

struct MenuItems: View {

    @Environment(MusicPlayerManager.self) private var musicPlayerManager

    let item: MusicItem?
    var tracks: MusicItemCollection<Track>? = nil

    var body: some View {
        creatMenu()
    }

    @ViewBuilder
    private func creatMenu() -> some View {

        addToLibrary()
        addToPlaylist()
        Divider()

        playNext()
        playLast()
    }

    @ViewBuilder
    private func addToPlaylist() -> some View {

        Button {

        } label: {
            Label("Add to Playlist", systemImage: Symbols.musicNoteList.name)
        }
    }

    @ViewBuilder
    private func addToLibrary() -> some View {

        Button {

        } label: {
            Label("Add to Library", systemImage: Symbols.plus.name)
        }
    }

    @ViewBuilder
    private func playNext() -> some View {

        Button {
            if let track = item as? Track {
                musicPlayerManager.playNext(track, tracks)
            } else {
                musicPlayerManager.playNext()
            }
        } label: {
            Label("Play Next", systemImage: Symbols.playNext.name)
        }
    }

    @ViewBuilder
    private func playLast() -> some View {

        Button {
            musicPlayerManager.playLast()
        } label: {
            Label("Play Last", systemImage: Symbols.playLast.name)
        }
    }


}

#Preview {
    if let album = albumMock {
        MenuItems(item: album)
            .environment(MusicPlayerManager())
    }
}
