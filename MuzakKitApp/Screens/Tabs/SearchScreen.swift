//
//  SearchScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit
import Combine

struct SearchScreen: View {

    @State private var searchText: String = ""
    @State private var searchResults: MusicCatalogSearchResponse?

    var cancellables = Set<AnyCancellable>()

    var body: some View {

        SearchContainer(searchResults: $searchResults)
            .navigationTitle("Search")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(
                    displayMode: .always
                ),
                prompt: Text(
                    "Artists, Songs, Lyrics and More"
                )
            )
            .onChange(of: searchText) {
                conductSearch(for: searchText.lowercased())
            }
    }

    private func conductSearch(for searchTerm: String)  {
        // TODO: - debounce calls to search + add suggestions
        // handle empty search term case
        Task {
            let searchRequest = MusicCatalogSearchRequest(term: searchTerm, types: [Album.self, Song.self, Playlist.self, Station.self, Artist.self])

            let response = try await searchRequest.response()

            updateSearchResults(with: response)
        }
    }

    @MainActor
    private func updateSearchResults(with response: MusicCatalogSearchResponse) {
        Task {
            withAnimation {
                self.searchResults = response
            }
        }
    }
}

struct SearchContainer: View {

    @Environment(NavPath.self) private var navigation
    @Environment(\.isSearching) private var isSearching

    @State var genres: MusicCatalogResourceResponse<Genre>? = nil
    @Binding var searchResults: MusicCatalogSearchResponse?

    var body: some View {
        GeometryReader { proxy in
            List {
                if isSearching {
                    searchPageView(proxy)
                } else {
                    categoriesView()
                }
            }.listStyle(.plain)
        }
        .onChange(of: isSearching) {
            searchResults = nil
        }
        .task { await loadData() }
    }

    @ViewBuilder
    private func searchPageView(_ proxy: GeometryProxy) -> some View {

        let screenWidth = proxy.size.width

        if let searchResults = searchResults {

            Text("Search Results")
                .font(.title2)
                .fontWeight(.bold)
                .listRowSeparator(.hidden)

            Section {

                Text("Albums")
                    .sectionHeader()

                HorizontalGrid(
                    grid: 2.4,
                    rows: 2,
                    gutterSize: 12,
                    width: screenWidth
                ) { width in

                    ForEach(searchResults.albums, id: \.self) { item in

                        AlbumItemCell(item: item, size: width).onTapGesture {
                            navigation.path.append(item)
                        }
                    }
                }.horizontalDefaultInsets()
            }.listRowSeparator(.hidden)

            Section {

                Text("Songs")
                    .sectionHeader()

                HorizontalGrid(
                    grid: 1.15,
                    rows: 4,
                    gutterSize: 12,
                    width: screenWidth
                ) { width in
                    ForEach(searchResults.songs, id: \.self) { item in
                        SongItemCell(item: item, width: width).onTapGesture {
                            navigation.path.append(item)
                        }
                    }
                }.horizontalDefaultInsets()
            }.listRowSeparator(.hidden)

            Section {

                Text("Artists")
                    .sectionHeader()

                HorizontalGrid(
                    grid: 2.4,
                    rows: 1,
                    gutterSize: 12,
                    width: screenWidth
                ) { width in

                    ForEach(searchResults.artists, id: \.self) { item in

                        ArtistItemCell(item: item, size: 168).onTapGesture {
                            navigation.path.append(item)
                        }
                    }
                }.horizontalDefaultInsets()
            }.listRowSeparator(.hidden)
        }
    }

    @ViewBuilder
    private func songCell(for item: Song) -> some View {

        HStack {

            if let artwork = item.artwork {
                ArtworkImage(artwork, width: 50)
                    .artworkCornerRadius(.large)
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
        .frame(width: 318)
    }

    @ViewBuilder
    private func categoriesView() -> some View {

        if let genres = genres, !genres.items.isEmpty {

            VStack(alignment: .leading) {

                Text("Browse Categories")
                    .sectionHeader()

                LazyVGrid(
                    columns: [
                        GridItem(spacing: 12),
                        GridItem(spacing: 12)
                    ],
                    alignment: .center,
                    spacing: 12
                ){
                    ForEach(genres.items, id: \.self) { genre in
                        GenreItemCell(genre: genre).onTapGesture {
                            navigation.path.append(genre)
                        }
                    }
                }.listRowSeparator(.hidden)
            }
        }
    }
}

extension SearchContainer {

    private func loadData() async {

        do {

            let charts = MusicCatalogResourceRequest<Genre>()
            let items = try await charts.response()

            updateView(with: items)
        } catch {
            print("Can't load data for search results: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func updateView(with items: MusicCatalogResourceResponse<Genre>?) {
        Task {
            withAnimation {
                self.genres = items
            }
        }
    }
}
