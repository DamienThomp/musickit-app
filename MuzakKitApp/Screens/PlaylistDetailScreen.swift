//
//  PlaylistDetailScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-24.
//


//
//  AlbumDetailScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-23.
//

import SwiftUI
import MusicKit

struct PlaylistDetailScreen: View {

    @Environment(MusicPlayerManager.self) private var musicPlayer

    let playlist: Playlist

    @State private var tracks: MusicItemCollection<Track>?

    private var artwork: Artwork? {
        playlist.artwork
    }

    private var name: String {
        playlist.name
    }

    private var curatorName: String? {
        playlist.curatorName
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

                        if let artwork = track.artwork {
                            ArtworkImage(artwork, width: 40).clipShape(RoundedRectangle(cornerRadius: 8))
                        }

                        Text(track.title)
                            .lineLimit(1)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: "ellipsis").foregroundStyle(.pink)
                    }.onTapGesture {
                        musicPlayer.handleTrackSelected(for: track, from: tracks)
                    }
                }
            }
        }
        .tint(.pink)
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

            Text(name)
                .font(.system(.title2))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
            if let curatorName {
                Text(curatorName)
                    .font(.system(.title2))
                    .foregroundStyle(.pink)
            }
        }
    }

    private var actions: some View {
        DetailPageActions {
            if musicPlayer.isPlaying {
                musicPlayer.togglePlayBack()
            } else {
                musicPlayer.handlePlayback(for: playlist)
            }
        } _: {
            musicPlayer.shufflePlayback(for: playlist)
        }

    }

    private func loadTracks() async throws {
        let playlist = try await playlist.with([.tracks, .featuredArtists])
        update(tracks: playlist.tracks)
    }

    @MainActor
    private func update(tracks: MusicItemCollection<Track>?) {
        withAnimation {
            self.tracks = tracks
        }
    }
}
