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

        GeometryReader {

            let width = $0.size.width

            List {

                if let topItems = catalogItems?.topResults {

                    Section {
                        HorizontalGrid(
                            grid: 1.15,
                            rows: 1,
                            gutterSize: 12,
                            viewAligned: false,
                            width: width
                        ) { width in
                            ForEach(topItems, id: \.self) { item in
                                renderCard(for: item, with: width)
                                    .onTapGesture {
                                        handleTopItemTap(for: item)
                                    }
                            }
                        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }.listRowSeparator(.hidden)
                }

                if let songs = charts?.songCharts {

                    ForEach(songs, id: \.self) { section in

                        Section {
                            Text(section.title)
                                .sectionHeader()

                            HorizontalGrid(
                                grid: 1.15,
                                rows: 4,
                                gutterSize: 12,
                                width: width
                            ) { width in
                                ForEach(section.items, id: \.self) { item in
                                    songCell(for: item, width: width)
                                }
                            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }.listRowSeparator(.hidden)
                    }
                }

                if let albums = charts?.albumCharts {

                    ForEach(albums, id: \.self) { section in

                        Section {
                            Text(section.title)
                                .sectionHeader()

                            HorizontalGrid(
                                grid: 2.4,
                                rows: 2,
                                gutterSize: 12,
                                width: width
                            ) { width in
                                ForEach(section.items, id: \.self) { item in

                                    AlbumItemCell(item: item, size: width)
                                        .onTapGesture {
                                            navigation.path.append(item)
                                        }
                                }
                            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }.listRowSeparator(.hidden)
                    }
                }

                if let playlists = charts?.playlistCharts {

                    ForEach(playlists, id: \.self) { section in

                        Section {
                            Text(section.title)
                                .sectionHeader()

                            HorizontalGrid(
                                grid: 2.4,
                                rows: 1,
                                gutterSize: 12,
                                viewAligned: false,
                                width: width
                            ) { width in
                                ForEach(section.items, id: \.self) { item in
                                    PlaylistItemCell(item: item, size: 168)
                                        .onTapGesture {
                                            navigation.path.append(item)
                                        }

                                }
                            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }.listRowSeparator(.hidden)
                    }
                }

                if let artists = catalogItems?.artists {
                    Section {
                        Text("\(genre.name) Atists")
                            .sectionHeader()

                        HorizontalGrid(
                            grid: 2.4,
                            rows: 1,
                            gutterSize: 12,
                            viewAligned: false,
                            width: width
                        ) { width in
                            ForEach(artists, id: \.self) { item in
                                ArtistItemCell(item: item, size: width).onTapGesture {
                                    navigation.path.append(item)
                                }
                            }
                        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }.listRowSeparator(.hidden)
                }

                if let catalogAlbums = catalogItems?.albums {

                    Section {

                        Text("\(genre.name) Albums")
                            .sectionHeader()

                        HorizontalGrid(
                            grid: 2.4,
                            rows: 1,
                            gutterSize: 12,
                            viewAligned: false,
                            width: width
                        ) { width in
                            ForEach(catalogAlbums, id: \.self) { item in
                                AlbumItemCell(item: item, size: width).onTapGesture {
                                    navigation.path.append(item)
                                }
                            }
                        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }.listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        }
        .task {
            try? await loadGenreSections()
        }
        .navigationTitle(genre.name)
    }

    @ViewBuilder
    private func songCell(for item: Song, width: CGFloat) -> some View {

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
        .frame(width: width)
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

        let genreChartsRquest = MusicCatalogChartsRequest(
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
        var genreRequest = MusicCatalogSearchRequest(term: genre.name, types: [Album.self, Station.self, Playlist.self, Artist.self])
        genreRequest.includeTopResults = true
        genreRequest.limit = 25

        let charts = try await genreChartsRquest.response()
        let items = try await genreRequest.response()
        updateView(charts, items)
    }

    @MainActor
    private func updateView(_ charts: MusicCatalogChartsResponse, _ items: MusicCatalogSearchResponse) {
        Task {
            withAnimation(.easeInOut) {
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
        }
        .environment(MusicPlayerManager())
        .environment(NavPath())
    }
}
