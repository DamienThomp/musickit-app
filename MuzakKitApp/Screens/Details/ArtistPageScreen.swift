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
    let screenHeight = UIScreen.main.bounds.height

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

                            VStack(alignment: .leading) {

                                SectionTitle(title: albums.title ?? "Albums by \(artist.name)")

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(albums, id: \.self) { album in
                                        NavigationLink(value: album) {
                                            AlbumItemCell(item: album, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
                        }

                        if let compilations = artistDetails.compilationAlbums, !compilations.isEmpty {

                            VStack(alignment: .leading) {

                                SectionTitle(title: compilations.title ?? "Compilations by \(artist.name)")

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(compilations, id: \.self) { album in
                                        NavigationLink(value: album) {
                                            AlbumItemCell(item: album, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
                        }

                        if let singles = artistDetails.singles, !singles.isEmpty {

                            VStack(alignment: .leading) {

                                SectionTitle(title: singles.title ?? "Singles by \(artist.name)")

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(singles, id: \.self) { album in
                                        NavigationLink(value: album) {
                                            AlbumItemCell(item: album, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
                        }

                        if let appearsOn = artistDetails.appearsOnAlbums, !appearsOn.isEmpty {

                            VStack(alignment: .leading) {

                                SectionTitle(title: appearsOn.title ?? "Appears on")

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(appearsOn, id: \.self) { album in
                                        NavigationLink(value: album) {
                                            AlbumItemCell(item: album, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
                        }

                        if let featured = artistDetails.featuredAlbums, !featured.isEmpty {

                            VStack(alignment: .leading) {

                                SectionTitle(title: featured.title ?? "Featured on")

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(featured, id: \.self) { album in
                                        NavigationLink(value: album) {
                                            AlbumItemCell(item: album, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
                        }

                        if let playlists = artistDetails.playlists, !playlists.isEmpty {

                            VStack(alignment: .leading) {

                                SectionTitle(title: playlists.title ?? "Playlists")

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(playlists, id: \.self) { item in
                                        NavigationLink(value: item) {
                                            PlaylistItemCell(item: item, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
                        }

                        if let similarArtists = artistDetails.similarArtists, !similarArtists.isEmpty {

                            VStack(alignment: .leading) {

                                SectionTitle(title: similarArtists.title ?? "Similar Artists")

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(similarArtists, id: \.self) { item in
                                        NavigationLink(value: item) {
                                            ArtistItemCell(item: item, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
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
        .toolbarBackground(showNavigationBar ? .visible : .hidden, for: .navigationBar)
    }

    @ViewBuilder
    private func header(_ artistDetails: Artist) -> some View {

        ZStack(alignment: .bottom) {

            StretchyHeader(
                coordinateSpace: CoordinateSpace.scrollView,
                defaultHeight: initialHeight
            ) {

                if let artworkUrk = artist.artwork?.url(width: Int(initialHeight * 1.85), height: Int(initialHeight * 1.85)) {

                    AsyncImage(url: artworkUrk, transaction: Transaction(animation: .spring())) { phase in
                        phase.image?
                            .resizableImage(.fill)
                            .background(Color(.black))
                            .mask {
                                LinearGradient(
                                    colors: [
                                        .black.opacity(0),
                                        .black,
                                        .black
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                    }
                }
            }

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
            .tint(showNavigationBar ? .pink : Color(.systemGray2).opacity(0.6))
            .foregroundStyle(.primary)
        }

        ToolbarItem(placement: .principal) {
            Text(artist.name)
                .opacity(showNavigationBar ? 1.0 : 0)
        }
    }
}

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
