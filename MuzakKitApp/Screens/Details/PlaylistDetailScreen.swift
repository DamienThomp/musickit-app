//
//  PlaylistDetailScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-24.
//

import SwiftUI
import MusicKit

struct PlaylistDetailScreen: View {

    @Environment(MusicPlayerManager.self) private var musicPlayer

    let playlist: Playlist

    @State private var tracks: MusicItemCollection<Track>?
    @State private var featuredArtists: MusicItemCollection<Artist>?

    private var artwork: Artwork? {
        playlist.artwork
    }

    private var name: String {
        playlist.name
    }

    private var curatorName: String? {
        playlist.curatorName
    }

    private var count: Int? {
        tracks?.count
    }

    var body: some View {

        List {
            
            header
                .plainHeaderStyle()
                .frame(maxWidth: .infinity)

            actions
                .plainHeaderStyle()
                .padding(.bottom)

            if let tracks = tracks, !tracks.isEmpty {
                Section {
                    ForEach(tracks) { track in
                        PlaylistTrackCell(track: track)
                            .onTapGesture {
                                musicPlayer
                                    .handleTrackSelected(
                                        for: track,
                                        from: tracks
                                    )
                            }
                    }
                } footer: {
                    HStack {
                        if let count = count {
                            Text("\(count) songs")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                        }
                    }.padding(.vertical)
                }
            }

            if let artists = featuredArtists, !artists.isEmpty {

                ItemsSectionView(artists.title ?? "Featured Artists") {
                    ForEach(artists, id: \.self) { artist in
                        NavigationLink(value: artist) {
                            ArtistItemCell(item: artist, size: 160)
                        }.tint(.primary)
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
            musicPlayer.handlePlayback(for: playlist)
        } _: {
            musicPlayer.shufflePlayback(for: playlist)
        }
    }
}

extension PlaylistDetailScreen {

    private func loadTracks() async throws {
        let playlist = try await playlist.with([.tracks, .featuredArtists])
        update(tracks: playlist.tracks, artists: playlist.featuredArtists)
    }

    @MainActor
    private func update(tracks: MusicItemCollection<Track>?, artists: MusicItemCollection<Artist>?) {
        withAnimation {
            self.tracks = tracks
            self.featuredArtists = artists
        }
    }
}
