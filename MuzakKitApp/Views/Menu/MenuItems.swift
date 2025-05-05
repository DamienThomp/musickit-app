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
        createMenu()
            .task {
                checkLibrary(item: item)
            }
            .alert(errorMessage, isPresented: $showAlert) {
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
                try await musicService.library.addToLibrary(item)
                updateLibraryStatus(true)
            } catch {
                errorMessage = "Failed to add to Lirbary"
            }
        }
    }

    // TODO: - improve this method to remove the switch statement casting and repetition
    private func checkLibrary(item: MusicItem?) {

        guard let item else { return }

        Task {

            do {
                switch item {
                case let song as Song:
                    let response = try await musicService.library.isInLibrary(for: song, idKeyPath: \.id)
                    updateLibraryStatus(response)
                case let album as Album:
                    let response = try await musicService.library.isInLibrary(for: album, idKeyPath: \.id)
                    updateLibraryStatus(response)
                case let playlist as Playlist:
                    let response = try await musicService.library.isInLibrary(for: playlist, idKeyPath: \.id)
                    updateLibraryStatus(response)
                case let track as Track:
                    let response = try await musicService.library.isInLibrary(for: track, idKeyPath: \.id)
                    updateLibraryStatus(response)
                default:
                    print("Item type not supported for library check: \(type(of: item))")
                }
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
    private func createMenu() -> some View {

        if !isInLibrary {
            addToLibrary()
        }

        if let item = item as? Album {
            playMusicItem(item)
        }

        addToPlaylist()
        Divider()

        playNext()
        playLast()
    }

    @ViewBuilder
    private func playMusicItem(_ album: Album) -> some View {

        Button {
            musicPlayer.handlePlayback(for: album)
        } label: {
            Label("Play", systemImage: Symbols.play.name)
        }
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
    let musickitService = MusicKitServiceFactory.create()

    if let album = albumMock {
        MenuItems(item: album, isInLibrary: $isInLibrary)
            .environment(MusicPlayerService())
            .environment(musickitService)
    }
}
