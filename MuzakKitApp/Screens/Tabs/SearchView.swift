//
//  SearchView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit
import Combine

struct SearchContainer: View {

    @Environment(NavPath.self) private var navigation
    @Environment(\.isSearching) private var isSearching

    @State var genres: MusicCatalogResourceResponse<Genre>? = nil
    @Binding var searchResults: MusicCatalogSearchResponse?

    var body: some View {
        List {
            if isSearching {
                searchPageView()
            } else {
                categoriesView()
            }
        }
        .listStyle(.plain)
        .task {
            try? await loadData()
        }.onChange(of: isSearching) {
            searchResults = nil
        }
    }

    @ViewBuilder
    private func genreCell(for genre: MusicItemCollection<Genre>.Element) -> some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color.randomColor)
                .frame(height: 120)
            Text(genre.name)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
                .background(LinearGradient(colors: [.black.opacity(0), .black.opacity(0.5)], startPoint: .top, endPoint: .bottom))
        }.clipShape(RoundedRectangle(cornerRadius: 12))
    }

    @ViewBuilder
    private func searchPageView() -> some View {

        if let searchResults = searchResults {

            Text("Search Results")
                .font(.title2)
                .fontWeight(.bold)
                .listRowSeparator(.hidden)

            Section {
                Text("Albums").sectionHeader()

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
                        ForEach(searchResults.albums, id: \.self) { item in

                            AlbumItemCell(item: item, size: 168)
                        }
                    }
                    .scrollTargetLayout()
                }.listRowSeparator(.hidden)
            }
        }
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
                        genreCell(for: genre).onTapGesture {
                            navigation.path.append(genre)
                        }
                    }
                }.listRowSeparator(.hidden)
            }
        }
    }
}

struct SearchView: View {
    
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

extension SearchContainer {

    private func loadData() async throws {

        let charts = MusicCatalogResourceRequest<Genre>()
        let items = try await charts.response()

        updateView(with: items)
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

#Preview {
    if let genres = genreMock {
        AppRootNavigation {
            SearchView()
        }
        .environment(NavPath())
        .environment(MusicPlayerManager())
    }
}
