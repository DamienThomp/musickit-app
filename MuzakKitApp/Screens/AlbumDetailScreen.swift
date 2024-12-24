//
//  AlbumDetailScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-23.
//

import SwiftUI
import MusicKit

struct AlbumDetailScreen: View {

    let album: Album

    @State private var tracks: MusicItemCollection<Track>?

    private var artwork: Artwork? {
        album.artwork
    }

    private var title: String {
        album.title
    }

    private var artistName: String {
        album.artistName
    }

    var body: some View {
        List {
            header
                .padding(.bottom)
                .listStyle(.plain)
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

            actions
                .padding(.bottom)
                .listStyle(.plain)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

            if let tracks = tracks, !tracks.isEmpty {
                ForEach(tracks) { track in
                    HStack(spacing: 4) {
                        Text(track.trackNumber ?? 0, format: .number)
                            .foregroundStyle(.secondary)
                        Text(track.title)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: "ellipsis").foregroundStyle(.pink)
                    }
                    .onTapGesture {
                        handleTrackSelected(track)
                    }
                }
            }
        }
        .listStyle(.plain)
        .task {
            try? await loadTracks()
        }
    }

    private var header: some View {
        VStack(alignment: .center) {
            if let artwork {
                ArtworkImage(
                    artwork,
                    width: 240,
                    height: 240
                )
                .cornerRadius(12)
                .padding(.bottom)
            }

            Text(title)
                .font(.system(.title2))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
            Text(artistName)
                .font(.system(.title2))
                .foregroundStyle(.pink)
        }
    }

    private var actions: some View {
        HStack {
            Button {
                handlePlayButtonSelected()
            } label: {
                HStack {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    Text(isPlaying ? "Pause" : "Play")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.bordered)

            Button {
                shuffPlayback()
            } label: {
                HStack {
                    Image(systemName: "shuffle")
                    Text("Shuffle")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
        .controlSize(.large)
        .padding(.horizontal, 24)
        .tint(.secondary)
        .foregroundStyle(.pink)
    }

    private func loadTracks() async throws {
        let album = try await album.with([.tracks])
        update(tracks: album.tracks)
    }

    @MainActor
    private func update(tracks: MusicItemCollection<Track>?) {
        withAnimation {
            self.tracks = tracks
        }
    }

    // MARK: - Playback
    // TODO: - Create Player Manager Service
    /// The MusicKit player to use for Apple Music playback.
    private let player = ApplicationMusicPlayer.shared

    /// The state of the MusicKit player to use for Apple Music playback.
    @ObservedObject private var playerState = ApplicationMusicPlayer.shared.state

    /// `true` when the album detail view sets a playback queue on the player.
    @State private var isPlaybackQueueSet = false

    /// `true` when the player is playing.
    private var isPlaying: Bool {
        return (playerState.playbackStatus == .playing)
    }
    /// The action to perform when the user taps the Play/Pause button.
    private func handlePlayButtonSelected() {
        if !isPlaying {
            if !isPlaybackQueueSet {
                player.queue = [album]
                isPlaybackQueueSet = true
                beginPlaying()
            } else {
                Task {
                    do {
                        try await player.play()
                    } catch {
                        print("Failed to resume playing with error: \(error).")
                    }
                }
            }
        } else {
            player.pause()
        }
    }

    /// The action to perform when the user taps a track in the list of tracks.
    private func handleTrackSelected(_ track: Track) {
        guard let loadedTracks = self.tracks else { return }
        player.queue = ApplicationMusicPlayer.Queue(for: loadedTracks, startingAt: track)
        isPlaybackQueueSet = true
        beginPlaying()
    }

    private func shuffPlayback() {

        if isPlaying {
            player.pause()
        }

        if player.state.shuffleMode == .off {
            player.state.shuffleMode = .songs
        } else {
            player.state.shuffleMode = .off
        }

        player.queue = [album]
        isPlaybackQueueSet = true
        beginPlaying()
    }

    private func beginPlaying() {
        Task {
            do {
                try await player.play()
            } catch {
                print("Failed to prepare to play with error: \(error).")
            }
        }
    }
}
