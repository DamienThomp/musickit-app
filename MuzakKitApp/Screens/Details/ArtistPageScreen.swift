//
//  ArtistPageScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct ArtistPageScreen: View {

    @Environment(\.dismiss) var dismiss
    @Environment(MusicKitService.self) private var musicService
    @Environment(MusicPlayerService.self) private var musicPlayer

    private enum CoordinateSpace {
        case scrollView
    }

    let initialHeight = UIScreen.main.bounds.width
    let artist: Artist

    @State private var showNavigationBar: Bool = false

    private var artwork: Artwork? {
        artist.artwork
    }

    private var title: String {
        artist.name
    }

    private func toggleNavigationBar(_ value: CGFloat) {
        showNavigationBar = value < 0
    }

    var body: some View {

        GeometryReader { proxy in

            let size = proxy.size

            LoadingContainerView(loadingAction: fetchData) { artistDetails in

                ScrollView {

                    header(artistDetails)
                        .padding(.bottom, -10)

                    LazyVStack(alignment: .leading, spacing: 36) {

                        if let latest = artistDetails.latestRelease {

                            VStack(alignment: .leading) {
                                NavigationLink(value: latest) {
                                    heroCell(latest, size: size)
                                }.tint(.primary)
                            }
                        }

                        if let songs = artistDetails.topSongs {

                            VStack(alignment: .leading) {

                                SectionTitle(title: songs.title ?? "Top Songs")

                                HorizontalGrid(grid: 1.15, rows: 4, gutterSize: 12, width: size.width) { width in
                                    ForEach(songs, id: \.self) { item in
                                        SongItemCell(item: item, width: width) {
                                            musicPlayer.handleItemSelected(for: item, from: songs)
                                        }
                                    }
                                }
                            }
                        }

                        if let albums = artistDetails.albums, !albums.isEmpty {

                            MusicItemSection(
                                collection: albums,
                                fallbackTitle: "Albums by \(artist.name)",
                                width: size.width
                            )
                        }

                        if let compilations = artistDetails.compilationAlbums, !compilations.isEmpty {

                            MusicItemSection(
                                collection: compilations,
                                fallbackTitle: "Compilations by \(artist.name)",
                                width: size.width
                            )
                        }

                        if let singles = artistDetails.singles, !singles.isEmpty {

                            MusicItemSection(
                                collection: singles,
                                fallbackTitle: "Singles by \(artist.name)",
                                width: size.width
                            )
                        }

                        if let appearsOn = artistDetails.appearsOnAlbums, !appearsOn.isEmpty {

                            MusicItemSection(
                                collection: appearsOn,
                                fallbackTitle: "Appears on",
                                width: size.width
                            )
                        }

                        if let featured = artistDetails.featuredAlbums, !featured.isEmpty {

                            MusicItemSection(
                                collection: featured,
                                fallbackTitle: "Featured on",
                                width: size.width
                            )
                        }

                        if let playlists = artistDetails.playlists, !playlists.isEmpty {

                            MusicItemSection(
                                collection: playlists,
                                fallbackTitle: "Playlists",
                                width: size.width
                            )
                        }

                        if let similarArtists = artistDetails.similarArtists, !similarArtists.isEmpty {

                            MusicItemSection(
                                collection: similarArtists,
                                fallbackTitle: "Similar Artists",
                                width: size.width
                            )
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, proxy.safeAreaInsets.bottom + 20)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .background(Color(.systemGray6))
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                }
            }
            .coordinateSpace(.named(CoordinateSpace.scrollView))
            .ignoresSafeArea()
        }
        .background(Color(.systemBackground), ignoresSafeAreaEdges: .all)
        .navigationBarBackButtonHidden(true)
        .toolbar { toolBar() }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - View Builders
extension ArtistPageScreen {

    @ViewBuilder
    private func header(_ artistDetails: Artist) -> some View {

        ZStack(alignment: .bottom) {

            StretchyHeader(
                coordinateSpace: CoordinateSpace.scrollView,
                defaultHeight: initialHeight
            ) {

                if let artworkUrl = artist.artwork?.url(
                    width: Int(initialHeight * 1.85),
                    height: Int(initialHeight * 1.85)
                ) {
                    artworkHeader(artworkUrl: artworkUrl)
                }
            }

            headerOverlay()

            HStack {

                HeaderTitle(
                    text: title,
                    action: toggleNavigationBar
                )
                .padding()
                .font(.system(.largeTitle))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                headerAction(artistDetails)
                    .padding(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollTransition(axis: .vertical) { content, phase in
            content
                .opacity(phase.isIdentity ? 1.0 : 0.0)
        }
    }

    @ViewBuilder
    private func headerAction(_ artistDetails: Artist) -> some View {

        if let topSongs = artistDetails.topSongs,
           let firstSong = topSongs.first {

            Button {
                musicPlayer.handleItemSelected(for: firstSong, from: topSongs)
            } label: {
                Image(systemName: "play.fill")
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.borderedProminent)
            .tint(.pink)
            .foregroundStyle(.primary)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func heroCell(_ item: Album, size: CGSize) -> some View {

        TopResultCell(
            title: item.title,
            subtitle: item.artistName,
            artwork: item.artwork,
            size: size.width - 32
        )
        .padding(.horizontal)
    }

    @ToolbarContentBuilder
    private func toolBar() -> some ToolbarContent {

        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                Symbols.chevronBack.image
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.borderedProminent)
            .tint(showNavigationBar ? .pink : .gray)
            .foregroundStyle(.primary)
            .id(showNavigationBar)
        }

        ToolbarItem(placement: .principal) {
            Text(artist.name)
                .opacity(showNavigationBar ? 1.0 : 0)
        }
    }

    @ViewBuilder
    private func artworkHeader(artworkUrl: URL) -> some View {

        AsyncImage(url: artworkUrl, transaction: Transaction(animation: .spring())) { phase in

            if #available(iOS 26, *) {
                phase.image?
                    .resizableImage(.fill)
                    .background(Color(.black))
            } else {
                phase.image?
                    .resizableImage(.fill)
                    .background(Color(.black))
                    .mask {
                        LinearGradient(
                            colors: [.black.opacity(0), .black, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                }
            }
        }
    }

    @ViewBuilder
    private func headerOverlay() -> some View {

        if #available(iOS 26, *) {
            // iOS 26 — overlay causes issues
            EmptyView()
        } else {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [
                            .black.opacity(0.0),
                            .black.opacity(0.5)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .ignoresSafeArea(.container, edges: .all)
        }
    }
}

// MARK: - Data Fetching
extension ArtistPageScreen {

    private func fetchData() async throws -> Artist {
        return try await musicService.dataFetching.getData(
            for: artist,
            with:
                [
                    .albums,
                    .singles,
                    .appearsOnAlbums,
                    .similarArtists,
                    .featuredAlbums,
                    .playlists,
                    .latestRelease,
                    .compilationAlbums,
                    .topSongs
                ]
        )
    }
}

#Preview {
    if let artist = artistMock {

        let musicKitService = MusicKitServiceFactory.create()

        NavigationStack {
            ArtistPageScreen(artist: artist)
                .environment(musicKitService)
                .environment(MusicPlayerService())
        }
    }
}
