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

    @State var items: MusicCatalogChartsResponse? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                if let songs = items?.songCharts {

                    ForEach(songs, id: \.self) { section in
                        Text(section.title)
                            .sectionHeader()
                            .padding(.leading)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [
                                GridItem(), GridItem(), GridItem(), GridItem()
                            ], spacing: 12) {
                                ForEach(section.items, id: \.self) { item in
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
                                        }
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                        Spacer()

                                    }
                                    .frame(width: 250)
                                }
                            }
                        }.padding(.horizontal)
                    }
                }

                if let albums = items?.albumCharts {
                    ForEach(albums, id: \.self) { section in
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

                                    AlbumItemCell(item: item, size: 168).onTapGesture {
                                        navigation.path.append(item)
                                    }
                                }
                            }
                            .padding(.leading)
                            .scrollTargetLayout()
                        }
                    }
                }

                if let playlists = items?.playlistCharts {

                    ForEach(playlists, id: \.self) { section in
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

                                    PlaylistItemCell(item: item, size: 168).onTapGesture {
                                        navigation.path.append(item)
                                    }
                                }
                            }
                            .padding(.leading)
                            .scrollTargetLayout()
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
}

extension GenreView {

    private func loadGenreSections() async throws {
       
        let genreRequest = MusicCatalogChartsRequest(genre: genre, kinds: [.mostPlayed, .dailyGlobalTop],types: [Album.self, Playlist.self, Song.self])
        let items = try await genreRequest.response()

        updateView(with: items)
    }

    @MainActor
    private func updateView(with items: MusicCatalogChartsResponse) {
        Task {
            self.items = items
        }
    }
}

#Preview {
    if let mockData = mockGenrelist,
       let mockGenre = genreMock,
       let genre = mockGenre.items.first {
        AppRootNavigation {
            GenreView(genre: genre, items: mockData)
        }.environment(NavPath())
    }
}
