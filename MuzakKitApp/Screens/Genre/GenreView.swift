//
//  GenreView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit

struct GenreView: View {

    let genre: Genre

    @State var items: MusicCatalogChartsResponse? = nil

    var body: some View {
        List {
            if let songs = items?.songCharts {

                ForEach(songs, id: \.self) { section in
                    Text(section.title)
                        .sectionHeader()
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
                            }.listRowSeparator(.hidden)
                        }
                    }
                }.listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
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
            withAnimation {
                self.items = items
            }
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
