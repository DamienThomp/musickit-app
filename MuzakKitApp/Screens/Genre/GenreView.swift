//
//  GenreView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit

struct GenreView: View {

    @Environment(NavPath.self) private var navigation

    let genre: Genre

    @State var charts: MusicCatalogChartsResponse? = nil
    @State var catalogItems: MusicCatalogSearchResponse? = nil

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 30) {

                if let topItems = catalogItems?.topResults {

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem()], alignment: .bottom, spacing: 12) {
                            ForEach(topItems, id: \.self) { item in
                                renderCard(for: item, with: 324)
                                    .onTapGesture {
                                        handleTopItemTap(for: item)
                                }
                            }
                       }.scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal)
                    .scrollIndicators(.hidden)
                }

                if let songs = charts?.songCharts {

                    ForEach(songs, id: \.self) { section in

                        Section {
                            Text(section.title)
                                .sectionHeader()
                                .padding(.leading)

                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(
                                    rows: [
                                        GridItem(),
                                        GridItem(),
                                        GridItem(),
                                        GridItem()
                                    ],
                                    spacing: 12
                                ) {
                                    ForEach(section.items, id: \.self) { item in
                                        songCell(for: item)
                                    }
                                }
                            }.safeAreaPadding(.horizontal)
                        }
                    }
                }

                if let albums = charts?.albumCharts {

                    ForEach(albums, id: \.self) { section in

                        Section {
                            Text(section.title)
                                .sectionHeader()
                                .padding(.leading)

                            ScrollView(.horizontal, showsIndicators: false) {

                                LazyHGrid(
                                    rows: [GridItem(
                                        .adaptive(
                                            minimum: 250,
                                            maximum: 250
                                        )
                                    )],
                                    alignment: .top,
                                    spacing: 12
                                ) {
                                    ForEach(section.items, id: \.self) { item in

                                        AlbumItemCell(item: item, size: 168)
                                            .onTapGesture {
                                                navigation.path.append(item)
                                            }
                                    }
                                }
                            }.safeAreaPadding(.horizontal)
                        }
                    }
                }

                if let playlists = charts?.playlistCharts {

                    ForEach(playlists, id: \.self) { section in

                        Section {
                            Text(section.title)
                                .sectionHeader()
                                .padding(.leading)

                            ScrollView(.horizontal, showsIndicators: false) {

                                LazyHGrid(
                                    rows: [GridItem(
                                        .adaptive(
                                            minimum: 250,
                                            maximum: 250
                                        )
                                    )],
                                    alignment: .top,
                                    spacing: 12
                                ) {
                                    ForEach(section.items, id: \.self) { item in

                                        PlaylistItemCell(item: item, size: 168)
                                            .onTapGesture {
                                                navigation.path.append(item)
                                            }
                                    }
                                }
                            }.safeAreaPadding(.horizontal)
                        }
                    }
                }
            }
        }
        .task {
            try? await loadGenreSections()
        }
        .navigationTitle(genre.name)
    }

    @ViewBuilder
    private func songCell(for item: Song) -> some View {

        HStack {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: 50)
                    .cornerRadius(12)
            }
            VStack(alignment: .leading) {
                Text(item.title)
                Text(item.artistName)
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                Divider()
            }
            .lineLimit(1)
            .multilineTextAlignment(.leading)

            Spacer()
        }
        .frame(width: 250)
    }

    @ViewBuilder
    func renderCard(for item: MusicCatalogSearchResponse.TopResult, with size: CGFloat) -> some View {

        switch item {
        case .playlist(let playlist):
            TopResultCell(
                title: playlist.name,
                subtitle: playlist.curatorName,
                artwork: playlist.artwork,
                size: size
            )
        case .album(let album):
            TopResultCell(
                title: album.title,
                subtitle: album.artistName,
                artwork: album.artwork,
                size: size
            )
        case .artist(let artist):
            TopResultCell(
                title: artist.name,
                subtitle: nil,
                artwork: artist.artwork,
                size: size
            )
        case .station(let station):
            TopResultCell(
                title: station.name,
                subtitle: station.stationProviderName,
                artwork: station.artwork,
                size: size
            )
        case .recordLabel(_), .radioShow(_), .musicVideo(_), .song(_), .curator(_):
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }

    private func handleTopItemTap(for item: MusicCatalogSearchResponse.TopResult) {
        switch item {
        case .album(let album):
            navigation.path.append(album)
        case .artist(let artist):
            navigation.path.append(artist)
        case .playlist(let playlist):
            navigation.path.append(playlist)
        case .station(_):
            print("start station")
        case .curator(_), .musicVideo(_), .radioShow(_), .recordLabel(_), .song(_):
            print("unhandled item")
        @unknown default:
            print("unhandled item")
        }
    }

}

extension GenreView {

    private func loadGenreSections() async throws {

        let genreRequest = MusicCatalogChartsRequest(
            genre: genre,
            kinds: [
                .mostPlayed,
                .dailyGlobalTop
            ],
            types: [
                Album.self,
                Playlist.self,
                Song.self
            ]
        )
        var genreOtherRequest = MusicCatalogSearchRequest(term: genre.name, types: [Album.self, Station.self, Playlist.self, Artist.self])
        genreOtherRequest.includeTopResults = true
        genreOtherRequest.limit = 25

        let charts = try await genreRequest.response()
        let items = try await genreOtherRequest.response()
        updateView(charts, items)
    }

    @MainActor
    private func updateView(_ charts: MusicCatalogChartsResponse, _ items: MusicCatalogSearchResponse) {
        Task {
            withAnimation {
                self.charts = charts
                self.catalogItems = items
            }
        }
    }
}

#Preview {
    if let mockData = mockGenrelist,
       let mockGenre = genreMock,
       let genre = mockGenre.items.first {
        AppRootNavigation {
            GenreView(genre: genre, charts: mockData)
        }.environment(NavPath())
    }
}
