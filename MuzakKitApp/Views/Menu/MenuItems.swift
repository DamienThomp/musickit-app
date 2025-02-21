//
//  MenuItems.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-17.
//

import SwiftUI
import MusicKit

struct MenuItems: View {

    @Environment(MusicPlayerService.self) private var musicPlayer
    @Environment(MusicKitService.self) private var musicService

    let item: MusicItem?
    var tracks: MusicItemCollection<Track>?

    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false

    @Binding var isInLibrary: Bool

    var body: some View {
        creatMenu()
            .task {
                checkLibrary(for: item)
            }.alert(errorMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    errorMessage = ""
                }
            }
    }

    private func addToPlaylist() {
        guard let item = item as? MusicPlaylistAddable else { return }

        musicService.presentAddToPlaylistForm(for: item)
    }

    private func addToLibrary() {

        guard let item = item as? MusicLibraryAddable else { return }

        Task {
            do {
                try await musicService.addToLibrary(item)
                updateLibraryStatus(true)
            } catch {
                errorMessage = "Failed to add to Lirbary"
            }
        }
    }

    private func checkLibrary(for item: MusicItem?) {

        guard let item else { return }

        Task {
            do {
                let response = try await musicService.isInLirabry(item)
                updateLibraryStatus(response)
            } catch {
                print("failed to check library for item \(item.id) with error: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    private func updateLibraryStatus(_ status: Bool) {
        withAnimation {
            self.isInLibrary = status
        }
    }

    @ViewBuilder
    private func creatMenu() -> some View {

        if !isInLibrary {
            addToLibrary()
        }

        addToPlaylist()
        Divider()

        playNext()
        playLast()
    }

    @ViewBuilder
    private func addToPlaylist() -> some View {

        Button {
            addToPlaylist()
        } label: {
            Label("Add to Playlist", systemImage: Symbols.musicNoteList.name)
        }
    }

    @ViewBuilder
    private func addToLibrary() -> some View {

        Button {
            addToLibrary()
        } label: {
            Label("Add to Library", systemImage: Symbols.plus.name)
        }
    }

    @ViewBuilder
    private func playNext() -> some View {

        Button {
            if let track = item as? Track {
                musicPlayer.playNext(track, tracks)
            } else {
                musicPlayer.playNext()
            }
        } label: {
            Label("Play Next", systemImage: Symbols.playNext.name)
        }
    }

    @ViewBuilder
    private func playLast() -> some View {

        Button {
            musicPlayer.playLast()
        } label: {
            Label("Play Last", systemImage: Symbols.playLast.name)
        }
    }
}

#Preview {
    @Previewable @State var isInLibrary = false
    if let album = albumMock {
        MenuItems(item: album, isInLibrary: $isInLibrary)
            .environment(MusicPlayerService())
            .environment(MusicKitService())
    }
}
