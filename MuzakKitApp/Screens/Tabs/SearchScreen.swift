//
//  SearchScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit

enum SearchType: String, CaseIterable {

    case library
    case catalog

    var title: String {
        self.rawValue.capitalized
    }
}

struct SearchScreen: View {

    @Environment(MusicKitService.self) private var musicService
    @Environment(\.debounce) private var debounce

    @State private var searchType: SearchType = .library
    @State private var searchText: String = ""
    @State private var searchCatalogResults: MusicCatalogSearchResponse?
    @State private var searchLibraryResults: MusicLibrarySearchResponse?

    var body: some View {

        SearchContainer(
            searchCatalogResults: $searchCatalogResults,
            searchLibraryResults: $searchLibraryResults,
            searchType: $searchType
        )
        .navigationTitle("Search")
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(
                displayMode: .always
            ),
            prompt: Text(
                "Artists, Albums and More"
            )
        )
        .onSubmit(of: .search) { conductSearch(for: searchText.lowercased(), of: searchType) }
        .onChange(of: searchText) { debounce.send(searchText) }
        .onChange(of: debounce.output) { conductSearch(for: debounce.output.lowercased(), of: searchType) }
        .onChange(of: searchType) {
            clearResults()

            if !searchText.isEmpty {
                conductSearch(for: searchText.lowercased(), of: searchType)
            }
        }
        .onDisappear { debounce.cancel() }
        .onAppear { conductSearch(for: searchText.lowercased(), of: searchType) }
    }

    private func clearResults() {
        searchCatalogResults = nil
        searchLibraryResults = nil
    }

    private func conductSearch(for query: String, of type: SearchType) {

        guard !query.isEmpty else {
            clearResults()
            return
        }

        Task {
            do {
                switch type {
                case .library:
                    let response = try await musicService.search.searchLibrary(
                        with: query,
                        for: [
                            Album.self,
                            Song.self,
                            Playlist.self,
                            Artist.self
                        ]
                    )
                    updateSearchResults(with: response)
                case .catalog:
                    let response = try await musicService.search.searchCatalog(with: query)
                    updateSearchResults(with: response)
                }
            } catch {
                print("Can't load search results for \(type.title) with error: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    private func updateSearchResults(with response: MusicCatalogSearchResponse) {

        withAnimation {
            self.searchCatalogResults = response
        }
    }

    @MainActor
    private func updateSearchResults(with response: MusicLibrarySearchResponse) {
        
        withAnimation {
            self.searchLibraryResults = response
        }
    }
}

struct SearchContainer: View {

    @Environment(NavPath.self) private var navigation
    @Environment(\.isSearching) private var isSearching

    @State var genres: MusicCatalogResourceResponse<Genre>?
    @Binding var searchCatalogResults: MusicCatalogSearchResponse?
    @Binding var searchLibraryResults: MusicLibrarySearchResponse?
    @Binding var searchType: SearchType

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
            searchCatalogResults = nil
            searchLibraryResults = nil
        }
        .task(loadData)
    }

    @ViewBuilder
    private func searchPageView(_ proxy: GeometryProxy) -> some View {

        let screenWidth = proxy.size.width

        Picker("Search in", selection: $searchType) {
            ForEach(SearchType.allCases, id: \.self) { selection in
                Text(selection.title).tag(selection)
            }
        }.pickerStyle(.segmented)

        if let catalog = searchCatalogResults {
            catalogResults(screenWidth, catalog: catalog)
        }

        if let library = searchLibraryResults {
            libraryResults(screenWidth, library: library)
        }
    }

    @ViewBuilder
    private func catalogResults(_ screenWidth: CGFloat, catalog: MusicCatalogSearchResponse) -> some View {

        Text("Search Catalog Results")
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

                ForEach(catalog.albums, id: \.self) { item in

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
                ForEach(catalog.songs, id: \.self) { item in
                    SongItemCell(item: item, width: width) {
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
            ) { _ in

                ForEach(catalog.artists, id: \.self) { item in

                    ArtistItemCell(item: item, size: 168).onTapGesture {
                        navigation.path.append(item)
                    }
                }
            }.horizontalDefaultInsets()
        }.listRowSeparator(.hidden)
    }

    @ViewBuilder
    private func libraryResults(_ screenWidth: CGFloat, library: MusicLibrarySearchResponse) -> some View {

        Text("Search Library Results")
            .font(.title2)
            .fontWeight(.bold)
            .listRowSeparator(.hidden)

        if !library.albums.isEmpty {

            Section {
                Text("Albums")
                    .sectionHeader()

                HorizontalGrid(
                    grid: 2.4,
                    rows: library.albums.count > 4 ? 2 : 1,
                    gutterSize: 12,
                    width: screenWidth
                ) { width in

                    ForEach(library.albums, id: \.self) { item in

                        AlbumItemCell(item: item, size: width).onTapGesture {
                            navigation.path.append(item)
                        }
                    }
                }.horizontalDefaultInsets()
            }
        }

        if !library.songs.isEmpty {

            Section {

                Text("Songs")
                    .sectionHeader()

                HorizontalGrid(
                    grid: 1.15,
                    rows: 4,
                    gutterSize: 12,
                    width: screenWidth
                ) { width in
                    ForEach(library.songs, id: \.self) { item in
                        SongItemCell(item: item, width: width) {
                            navigation.path.append(item)
                        }
                    }
                }.horizontalDefaultInsets()
            }.listRowSeparator(.hidden)
        }

        if !library.artists.isEmpty {

            Section {

                Text("Artists")
                    .sectionHeader()

                HorizontalGrid(
                    grid: 2.4,
                    rows: 1,
                    gutterSize: 12,
                    width: screenWidth
                ) { width in

                    ForEach(library.artists, id: \.id) { item in

                        ArtistItemCell(item: item, size: width).onTapGesture {
                            navigation.path.append(item)
                        }
                    }
                }.horizontalDefaultInsets()
            }.listRowSeparator(.hidden)
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
                ) {
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

    @Sendable
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

        withAnimation {
            self.genres = items
        }
    }
}
