//
//  AlbumLibraryScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-21.
//

import SwiftUI
import MusicKit

typealias SectionedALbumLibrary = [Dictionary<String.Element, [MusicItemCollection<Album>.Element]>.Element]

struct AlbumLibraryScreen: View {

    @Environment(MusicKitService.self) private var musicService
    @Environment(\.debounce) private var debounce

    @State private var albums: SectionedALbumLibrary?
    @State private var albumResults: MusicLibrarySearchResponse?

    @State private var searchText: String = ""

    var body: some View {

        GeometryReader {

            let screenWidth = $0.size.width

            ScrollView {

                AlbumsLibraryContainer(
                    screenWidth: screenWidth,
                    albums: $albums,
                    albumResults: $albumResults
                )
            }
            .frame(maxWidth: .infinity)
            .contentMargins([.horizontal, .top], 12)
        }
        .navigationTitle("Albums")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search) { searchAlbums(with: searchText.lowercased()) }
        .onChange(of: searchText) { debounce.send(searchText) }
        .onChange(of: debounce.output) { searchAlbums(with: debounce.output) }
        .onAppear { searchAlbums(with: searchText.lowercased()) }
        .onDisappear { debounce.cancel() }
        .task { loadAlbums() }
    }
}

extension AlbumLibraryScreen {

    private func searchAlbums(with query: String) {

        guard !query.isEmpty else {

            clearSearchResults()
            return
        }

        Task.detached {

            do {
                
                let response = try await musicService.searchLibrary(with: query, for: [Album.self])
                await updateSearchResults(with: response)
            } catch {
                print("Can't load search results for album with error: \(error.localizedDescription)")
            }
        }
    }

    private func loadAlbums() {

        Task.detached {

            do {

                var request = MusicLibraryRequest<Album>()
                request.sort(by: \.artistName, ascending: true)
                request.includeOnlyDownloadedContent = true

                let response = try await request.response()

                let sections = Dictionary(grouping: response.items) { $0.artistName.first ?? "?" }
                let ordered = sections.sorted( by: { $0.0 < $1.0 })

                await updateAlbums(with: ordered)
            } catch {
                print("Can't load albums with: \(error)")
            }
        }
    }

    @MainActor
    private func updateAlbums(with response: SectionedALbumLibrary?) {
        self.albums = response
    }

    @MainActor
    private func updateSearchResults(with response: MusicLibrarySearchResponse) {
        self.albumResults = response
    }

    @MainActor
    private func clearSearchResults() {
        self.albumResults = nil
    }
}

struct AlbumsLibraryContainer: View {

    @Environment(\.isSearching) private var isSearching
    @Environment(NavPath.self) private var navigation

    let screenWidth: CGFloat

    @Binding var albums: SectionedALbumLibrary?
    @Binding var albumResults: MusicLibrarySearchResponse?

    let count: Int = 2
    let gutters: CGFloat = 12

    private var gridColumns: [GridItem] {
        Array(repeating: .init(spacing: gutters), count: count)
    }

    private var spacing: CGFloat {
        gutters * CGFloat(count)
    }

    private var cellWidth: CGFloat {
        return (screenWidth / CGFloat(count)) - spacing
    }

    var body: some View {

        if isSearching {
            albumSearchResults()
        } else {
            albumSections()
        }
    }

    @ViewBuilder
    private func albumSearchResults() -> some View {

        if let albumResults = albumResults, !albumResults.albums.isEmpty {

            LazyVStack(alignment: .leading) {

                LazyVGrid(
                    columns: gridColumns,
                    alignment: .center,
                    spacing: spacing
                ) {
                    ForEach(albumResults.albums, id: \.id) { item in
                        AlbumItemCell(item: item, size: cellWidth)
                            .onTapGesture {
                                navigation.path.append(AppRootScreen.DetailsView.album(item))
                            }.id(item.id)
                    }
                }.frame(maxWidth: .infinity)
            }
        }
    }

    @ViewBuilder
    private func albumSections() -> some View {

        if let albums = albums, !albums.isEmpty {

            LazyVStack(alignment: .leading) {

                ForEach(albums, id: \.key) { section, value in

                    Text("\(section)")
                        .sectionHeader()
                        .padding(.leading, 8)

                    LazyVGrid(
                        columns: gridColumns,
                        alignment: .center,
                        spacing: spacing
                    ) {
                        ForEach(value, id: \.id) { item in
                            AlbumItemCell(item: item, size: cellWidth)
                                .onTapGesture {
                                    navigation.path.append(AppRootScreen.DetailsView.album(item))
                                }.id(item.id)
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }
    }
}
