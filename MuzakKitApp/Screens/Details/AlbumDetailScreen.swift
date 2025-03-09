//
//  AlbumDetailScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-23.
//

import SwiftUI
import MusicKit

struct AlbumDetailScreen: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.haptics) private var haptics

    @Environment(NavPath.self) private var navigation
    @Environment(MusicPlayerService.self) private var musicPlayer
    @Environment(MusicKitService.self) private var musicService

    let album: Album

    @State private var isInLibrary: Bool = false
    @State private var showNavigationTitle: Bool = false
    @State private var isAddingToLibrary: Bool = false

    private var artwork: Artwork? {
        album.artwork
    }

    private var title: String {
        album.title
    }

    private var artistName: String {
        album.artistName
    }

    private var background: LinearGradient {
        LinearGradient(
            colors: [
                Color(.systemBackground),
                Color(.systemBackground),
                Color(.systemGray6),
                Color(.systemGray6)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private func toggleNavigationBar(_ value: CGFloat) {
        showNavigationTitle = value < 0
    }

    var body: some View {

        LoadingContainerView(loadingAction: fetchData) { albumDetails in

            List {

                header(albumDetails.album)
                    .plainHeaderStyle()

                actions
                    .plainHeaderStyle()
                    .padding(.bottom)

                if let tracks = albumDetails.album.tracks, !tracks.isEmpty {

                    Section {

                        ForEach(tracks) { track in
                            AlbumTrackCell(track: track) {
                                MenuItems(item: track, tracks: tracks, isInLibrary: $isInLibrary)
                            }
                            .onTapGesture {
                                musicPlayer
                                    .handleItemSelected(
                                        for: track,
                                        from: tracks
                                    )
                            }
                            .contextMenu {
                                MenuItems(item: track, tracks: tracks, isInLibrary: $isInLibrary)
                            }
                        }
                    } footer: {
                        
                        if let copyright = albumDetails.album.copyright {
                            Text(copyright)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.vertical)
                                .listRowSeparator(.hidden)
                        }
                    }
                }

                if let artistAlbums = albumDetails.album.relatedAlbums, !artistAlbums.isEmpty {

                    ItemsSectionView("More by \(album.artistName)") {
                        ForEach(artistAlbums, id: \.self) { album in
                            NavigationLink(value: album) {
                                AlbumItemCell(item: album, size: 160)
                            }.tint(.primary)
                        }
                    }
                }

                if let related = albumDetails.similarArtist?.albums, !related.isEmpty {

                    ItemsSectionView(related.title) {
                        ForEach(related, id: \.self) { related in
                            NavigationLink(value: related) {
                                AlbumItemCell(item: related, size: 160)
                            }.tint(.primary)
                        }
                    }
                }

                if let similarArtists = albumDetails.similarArtist?.similarArtists, !similarArtists.isEmpty {

                    ItemsSectionView(similarArtists.title) {
                        ForEach(similarArtists, id: \.self) { artist in
                            NavigationLink(value: artist) {
                                ArtistItemCell(item: artist, size: 160)
                            }.tint(.primary)
                        }
                    }
                }
            }
            .background(background.ignoresSafeArea())
            .listStyle(.plain)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar { toolBar() }
        .task(getData)
    }

    @ViewBuilder
    private func header(_ album: Album) -> some View {

        VStack(alignment: .center, spacing: 2) {

            if let artwork {
                ArtworkImage(
                    artwork,
                    width: 240,
                    height: 240
                )
                .artworkCornerRadius(.large)
                .padding(.bottom, 12)
            }

            HeaderTitle(
                text: title,
                action: toggleNavigationBar
            )
            .font(.system(.title2))
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)

            Text(artistName)
                .font(.system(.title2))
                .foregroundStyle(.pink)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center).onTapGesture {
                    if let artist = album.artists?.first {
                        navigation.path.append(artist)
                    }
                }

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

    @ToolbarContentBuilder
    private func toolBar() -> some ToolbarContent {

        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                Symbols.chevronBack.image
                    .padding([.trailing, .vertical])
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            if isAddingToLibrary {
                ProgressView()
            } else {
                Button {
                    addToLibrary(album)
                } label: {
                    Image(systemName: isInLibrary ? Symbols.checkmarkCircle.name : Symbols.plusCircle.name)
                        .contentTransition(.symbolEffect(.replace))
                }
            }
        }

        ToolbarItem(placement: .topBarTrailing) {

            Menu {
                MenuItems(item: album, isInLibrary: $isInLibrary)
            } label: {
                Symbols.ellipsis.image
                    .padding([.vertical, .trailing], 12)
            }
            .contentShape(Rectangle())
        }

        ToolbarItem(placement: .principal) {
            Text(title)
                .lineLimit(1)
                .opacity(showNavigationTitle ? 1.0 : 0)
        }
    }
}

struct AlbumDetails: Codable {
    
    let album: Album
    let similarArtist: Artist?
}

extension AlbumDetailScreen {

    @Sendable
    private func getData() async {

        do {
            try await checkLibraryState(for: album)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func fetchData() async throws -> AlbumDetails {

        let album = try await musicService.getData(for: album, with: [.tracks, .relatedAlbums, .artists])
        let similarArtist = try await getSimilarArtists(from: album.artists)

        return .init(album: album, similarArtist: similarArtist)
    }

    private func getSimilarArtists(from artists: MusicItemCollection<Artist>?) async throws -> Artist? {

        guard let artist = artists?.first else { return nil }

        return try await musicService.getData(for: artist, with: [.similarArtists, .albums])
    }

    private func addToLibrary(_ album: Album) {

        guard !isInLibrary else { return }

        Task { @MainActor in

            do {
                self.isAddingToLibrary = true
                try await musicService.addToLibrary(album)
                haptics.notification(.success)
                self.isAddingToLibrary = false
                self.isInLibrary = true
            } catch {
                print("can't add to library: \(error.localizedDescription)")
                self.isAddingToLibrary = false
                haptics.notification(.error)
            }
        }
    }

    private func checkLibraryState(for album: Album) async throws {

        let response = try await musicService.isInLirabry(album)

        updateLibraryState(for: response)
    }

    @MainActor
    private func updateLibraryState(for response: Bool) {

        withAnimation {
            self.isInLibrary = response
        }
    }
}

#Preview {

    if let album = albumMock {
        NavigationStack {
            AlbumDetailScreen(album: album)
                .environment(NavPath())
                .environment(MusicPlayerService())
                .environment(MusicKitService())
        }.tint(.pink)
    }
}
