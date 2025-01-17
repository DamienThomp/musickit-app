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

    @State var tracks: MusicItemCollection<Track>? = nil
    @State private var related: MusicItemCollection<Album>?
    @State private var similarArtists: MusicItemCollection<Artist>?
    @State private var artistAlbums: MusicItemCollection<Album>?
    @State private var isInLibrary: Bool = false

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
                .plainHeaderStyle()

            actions
                .plainHeaderStyle()
                .padding(.bottom)

            if let tracks = tracks, !tracks.isEmpty {
                Section {

                    ForEach(tracks) { track in
                        AlbumTrackCell(track: track) {
                            MenuItems(item: track, tracks: tracks)
                        }
                        .onTapGesture {
                            musicPlayer
                                .handleTrackSelected(
                                    for: track,
                                    from: tracks
                                )
                        }
                        .contextMenu {
                            MenuItems(item: track, tracks: tracks)
                        }
                    }
                } footer: {
                    if let copyright = album.copyright {
                        Text(copyright)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.vertical)
                            .listRowSeparator(.hidden)
                    }
                }
            }

            if let artistAlbums = artistAlbums, !artistAlbums.isEmpty {

                ItemsSectionView("More by \(album.artistName)") {
                    ForEach(artistAlbums, id: \.self) { album in
                        NavigationLink(value: album) {
                            AlbumItemCell(item: album, size: 160)
                        }.tint(.primary)
                    }
                }
            }

            if let related = related, !related.isEmpty {

                ItemsSectionView(related.title) {
                    ForEach(related, id: \.self) { related in
                        NavigationLink(value: related) {
                            AlbumItemCell(item: related, size: 160)
                        }.tint(.primary)
                    }
                }
            }

            if let similarArtists = similarArtists, !similarArtists.isEmpty {

                ItemsSectionView(similarArtists.title) {
                    ForEach(similarArtists, id: \.self) { artist in
                        NavigationLink(value: artist) {
                            ArtistItemCell(item: artist, size: 160)
                        }.tint(.primary)
                    }
                }
            }
        }
        .background(Color(.systemGray6), ignoresSafeAreaEdges: .bottom)
        .listStyle(.plain)
        .task {
            do {
                try await checkLibraryState(for: album)
                try await loadTracks()
            } catch {
                print(error.localizedDescription)
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    addToLibrary(album)
                } label: {
                    Image(systemName: isInLibrary ? Symbols.checkmarkCircle.name : Symbols.plusCircle.name)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    MenuItems(item: album)
                } label: {
                    Symbols.ellipsis.image
                }
            }
        }
    }


    private var header: some View {

        VStack(alignment: .center, spacing: 2) {

            if let artwork {
                ArtworkImage(
                    artwork,
                    width: 240,
                    height: 240
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
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

                if let genre = album.genreNames.first {
                    Text(genre)
                    Symbols.circle.image
                        .imageScale(.small)
                        .font(.system(size: 4))
                }

                if let releaseDate = album.releaseDate {
                    Text(releaseDate, format: .dateTime.year())
                }
            }
            .font(.system(.caption2))
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .lineLimit(2)
    }

    private var actions: some View {

        DetailPageActions {
            musicPlayer.handlePlayback(for: album)
        } _: {
            musicPlayer.shufflePlayback(for: album)
        }
    }
}

extension AlbumDetailScreen {

    private func addToLibrary(_ album: Album) {

        guard !isInLibrary else { return }

        Task { @MainActor in
            do {
                let library = MusicLibrary.shared
                try await library.add(album)
                self.isInLibrary = true
            } catch {
                print("can't add to library: \(error.localizedDescription)")
            }
        }
    }

    private func checkLibraryState(for album: Album) async throws {

        var request: MusicLibraryRequest<Album> = MusicLibraryRequest()
        request.filter(matching: \.id, equalTo: album.id)

        let response = try await request.response()

        updateLibraryState(for: response)
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
    private func updateLibraryState(for response: MusicLibraryResponse<Album>) {
        withAnimation {
            self.isInLibrary = !response.items.isEmpty
        }
    }

    @MainActor
    private func update(tracks: MusicItemCollection<Track>?, related: MusicItemCollection<Album>?) {
        withAnimation {

            self.tracks = tracks
            self.related = related
        }
    }
}

#Preview {

    if let album = albumMock,
       let tracks = albumTracksMock {
        NavigationStack {
            AlbumDetailScreen(album: album, tracks: tracks)
                .environment(MusicPlayerManager())
        }.tint(.pink)
    }
}
