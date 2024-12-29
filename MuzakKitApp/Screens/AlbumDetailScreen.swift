//
//  AlbumDetailScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-23.
//

import SwiftUI
import MusicKit

struct AlbumDetailScreen: View {

    @Environment(MusicPlayerManager.self) private var musicPlayer

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
                        handleTrackSelected(for: track)
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
                handlePlayback()
            } label: {
                HStack {
                    Image(systemName: musicPlayer.isPlaying ? "pause.fill" : "play.fill")
                    Text(musicPlayer.isPlaying ? "Pause" : "Play")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.bordered)

            Button {
                handleShuffle()
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

    private func handleTrackSelected(for track: Track) {
        guard let loadedTracks = tracks else { return }
        musicPlayer.handleTrackSelected(for: track, from: loadedTracks)
    }

    private func handlePlayback() {
        if musicPlayer.isPlaying {
            musicPlayer.togglePlayBack()
        } else {
            musicPlayer.handlePlayback(for: album)
        }
    }

    private func handleShuffle() {
        musicPlayer.shufflePlayback(for: album)
    }
}
