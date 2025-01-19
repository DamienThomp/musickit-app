//
//  ArtistPageScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct ArtistPageScreen: View {

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

                    VStack(alignment: .leading, spacing: 20) {

                        if let latest = artistDetails.latestRelease {
                            Section {

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

                        if let albums = artistDetails.albums, !albums.isEmpty {

                            Section {

                                Text(albums.title ?? "Albums by \(artist.name)")
                                    .sectionHeader()
                                    .padding(.leading)


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

                            Section {

                                Text(compilations.title ?? "Compilations by \(artist.name)")
                                    .sectionHeader()
                                    .padding(.leading)


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

                            Section {

                                Text(singles.title ?? "Singles by \(artist.name)")
                                    .sectionHeader()
                                    .padding(.leading)


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

                            Section {

                                Text(appearsOn.title ?? "Appears on")
                                    .sectionHeader()
                                    .padding(.leading)

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

                            Section {

                                Text(featured.title ?? "Featured on")
                                    .sectionHeader()
                                    .padding(.leading)

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

                            Section {

                                Text(playlists.title ?? "Playlists")
                                    .sectionHeader()
                                    .padding(.leading)

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

                            Section {

                                Text(similarArtists.title ?? "Similar Artists")
                                    .sectionHeader()
                                    .padding(.leading)

                                HorizontalGrid(grid: 2.4, rows: 1, gutterSize: 12, viewAligned: false, width: size.width) { width in
                                    ForEach(similarArtists, id: \.self) { item in
                                        NavigationLink(value: item) {
                                            ArtistItemCell(item: item, size: width)
                                        }.tint(.primary)
                                    }
                                }
                            }
                        }

                        Section {
                            if let notes = artistDetails.editorialNotes?.standard {
                                Text(notes)
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
        .onAppear {
            loadSections()
        }
        .preferredColorScheme(.dark)
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
                            .resizable()
                            .aspectRatio(contentMode: .fill)
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

            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
                        .compilationAlbums
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
        ArtistPageScreen(artist: artist, artistDetails: artist)
    }
}
