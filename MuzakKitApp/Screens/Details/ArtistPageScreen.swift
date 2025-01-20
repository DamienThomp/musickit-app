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

    @State var artistDetails: Artist? = nil
    @State private var isLoading: Bool = true

    private var artwork: Artwork? {
        artist.artwork
    }

    private var title: String {
        artist.name
    }

    var body: some View {

        GeometryReader { proxy in

            let size = proxy.size

            ScrollView {

                if let artistDetails {

                    header()
                        .padding(.bottom, -10)

                    VStack(alignment: .leading, spacing: 36) {

                        if let latest = artistDetails.latestRelease {
                            VStack(alignment: .leading) {

                                NavigationLink(value: latest) {
                                    TopResultCell(
                                        title: latest.title,
                                        subtitle: latest.artistName,
                                        artwork: latest.artwork,
                                        size: size.width / 1.09
                                    ).padding(.horizontal)
                                }.tint(.primary)
                            }
                        }

                        if let songs = artistDetails.topSongs {

                            VStack(alignment: .leading) {

                                SectionTitle(title: songs.title ?? "Top Songs")

                                HorizontalGrid(
                                    grid: 1.15,
                                    rows: 4,
                                    gutterSize: 12,
                                    width: size.width
                                ) { width in
                                    ForEach(songs, id: \.self) { item in
                                        SongItemCell(item: item, width: width)
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
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Symbols.chevronBack.image
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.borderedProminent)
                .tint(Color(.systemGray2).opacity(0.6))
                .foregroundStyle(.primary)
            }
        }
        .onAppear {
            loadSections()
        }
    }

    @ViewBuilder
    private func header() -> some View {

        ZStack(alignment: .bottom) {

            StretchyHeader(
                coordinateSpace: CoordinateSpace.scrollView,
                defaultHeight: initialHeight
            ) {

                if let artworkUrk = artist.artwork?.url(width: Int(initialHeight * 1.5), height: Int(initialHeight * 1.5)) {

                    AsyncImage(url: artworkUrk) { phase in
                        phase.image?
                            .resizableImage(.fill)
                            .background(Color(.black))
                            .mask {
                                LinearGradient(colors: [.black.opacity(0), .black, .black], startPoint: .top, endPoint: .bottom)
                            }
                    }
                }
            }

            Rectangle()
                .fill(LinearGradient(colors: [.black.opacity(0.0), .black.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea(.container, edges: .all)

            HStack {
                Text(title)
                    .padding()
                    .font(.system(.largeTitle))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                headerAction()
                    .padding(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollTransition(axis: .vertical) { content, phase in
            content
                .opacity(phase.isIdentity ? 1.0 : 0.1)
        }
    }

    @ViewBuilder
    private func headerAction() -> some View {

        if let topSongs = artistDetails?.topSongs,
           let firstSong = topSongs.first {

            Button {
                musicPlayer.handleSongSelected(for: firstSong, from: topSongs)
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
}

extension ArtistPageScreen {

    private func loadSections() {

        Task {
            do {

                let artistDetails = try await artist.with(
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
                updateSections(with: artistDetails)
            } catch {
                print("can't load data: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    private func updateSections(with artist: Artist) {

        self.isLoading = false
        self.artistDetails = artist
    }
}

#Preview {

    if let artist = artistMock {

        NavigationStack {

            ArtistPageScreen(artist: artist, artistDetails: artist)
                .environment(MusicKitService())
                .environment(MusicPlayerService())
        }
    }
}
