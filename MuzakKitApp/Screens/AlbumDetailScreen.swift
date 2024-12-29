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
    @State private var related: MusicItemCollection<Album>?
    @State private var similarArtists: MusicItemCollection<Artist>?
    @State private var artistAlbums: MusicItemCollection<Album>?

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
                Section {
                    ForEach(tracks) { track in
                        HStack(spacing: 4) {
                            Text(track.trackNumber ?? 0, format: .number)
                                .foregroundStyle(.secondary)
                            Text(track.title)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 8)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Image(systemName: "ellipsis").foregroundStyle(.pink)
                        }
                        .onTapGesture {
                            handleTrackSelected(for: track)
                        }
                    }
                } footer: {
                    if let copyright = album.copyright {
                        Text(copyright)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.vertical)
                    }
                }
            }

            if let artistAlbums = artistAlbums, !artistAlbums.isEmpty {

                VStack(alignment: .leading, spacing: 12) {

                    Text("More by \(album.artistName)")
                        .padding(.leading)
                        .font(.system(.title2))

                    ScrollView(.horizontal) {
                        LazyHGrid(
                            rows: [GridItem(
                                .adaptive(
                                    minimum: 200,
                                    maximum: 250
                                )
                            )],
                            alignment: .top,
                            spacing: 12
                        ) {
                            ForEach(artistAlbums, id: \.self) { related in
                                itemCard(item: related, size: 160)
                            }
                        }
                        .padding(.leading)
                    }.scrollIndicators(.hidden)
                }
                .padding([.top, .bottom], 16)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .background(Color(.systemGray6))
            }

            if let related = related, !related.isEmpty {

                VStack(alignment: .leading, spacing: 12) {

                    if let title = related.title {
                        Text(title)
                            .padding(.leading)
                            .font(.system(.title2))

                    }

                    ScrollView(.horizontal) {
                        LazyHGrid(
                            rows: [GridItem(
                                .adaptive(
                                    minimum: 200,
                                    maximum: 250
                                )
                            )],
                            alignment: .top,
                            spacing: 12
                        ) {
                            ForEach(related, id: \.self) { related in
                                itemCard(item: related, size: 160)
                            }
                        }
                        .padding(.leading)
                    }.scrollIndicators(.hidden)
                }
                .padding([.top, .bottom], 16)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .background(Color(.systemGray6))
            }

            if let similarArtists = similarArtists, !similarArtists.isEmpty {
                VStack(alignment: .leading, spacing: 12) {

                    if let title = similarArtists.title {
                        Text(title)
                            .padding(.leading)
                            .font(.system(.title2))
                    }

                    ScrollView(.horizontal) {
                        LazyHGrid(
                            rows: [GridItem(
                                .adaptive(
                                    minimum: 200,
                                    maximum: 250
                                )
                            )],
                            alignment: .top,
                            spacing: 12
                        ) {
                            ForEach(similarArtists, id: \.self) { artist in
                                artistCard(item: artist, size: 160)
                            }
                        }.padding(.leading)
                    }.scrollIndicators(.hidden)
                }
                .padding([.top, .bottom], 16)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .background(Color(.systemGray6))
            }
        }
        .listStyle(.plain)
        .task {
            try? await loadTracks()
        }
    }

    func artistCard(item: Artist, size: CGFloat) -> some View {
        VStack {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .clipShape(Circle())
            }
            Text(item.name)
        }.frame(maxWidth: size)
    }

    func itemCard(item: Album, size: CGFloat) -> some View {
        VStack(alignment: .leading) {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .cornerRadius(8)
            } else {
                Image(systemName: "music.mic")
                    .resizable()
                    .foregroundStyle(.pink)
                    .background(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: size, height: size)
            }

            Text(item.title)
                .font(.system(.subheadline))
                .lineLimit(1)


            Text(item.artistName)
                .font(.system(.caption2))
                .foregroundStyle(.secondary)
                .lineLimit(1)

        }.frame(maxWidth: size)
    }

    private var header: some View {
        return VStack(alignment: .center, spacing: 2) {
            if let artwork {
                ArtworkImage(
                    artwork,
                    width: 240,
                    height: 240
                )
                .cornerRadius(12)
                .padding(.bottom, 14)
            }

            Text(title)
                .font(.system(.title2))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text(artistName)
                .font(.system(.title2))
                .foregroundStyle(.pink)
                .multilineTextAlignment(.center)
            HStack {
                Text(album.genreNames.first ?? "N/A")

                if let releaseDate = album.releaseDate {
                    Image(systemName: "circle.fill")
                        .imageScale(.small)
                        .font(.system(size: 8))
                    Text(releaseDate, format: .dateTime.year())
                }
            }
            .font(.system(.caption2))
            .foregroundStyle(.secondary)
        }
        .lineLimit(2)
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
        let album = try await album.with([.tracks, .relatedAlbums, .artists])
        try await loadSimilarArtists(album.artists)
        update(tracks: album.tracks, related: album.relatedAlbums)
    }

    private func loadSimilarArtists(_ artists: MusicItemCollection<Artist>?) async throws {

        guard let artist = artists?.first else { return }

        let response = try await artist.with([.similarArtists, .albums])

        Task { @MainActor in
            withAnimation {
                self.similarArtists = response.similarArtists
                self.artistAlbums = response.albums
            }
        }
    }

    @MainActor
    private func update(tracks: MusicItemCollection<Track>?, related: MusicItemCollection<Album>?) {
        withAnimation {
            self.tracks = tracks
            self.related = related
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
