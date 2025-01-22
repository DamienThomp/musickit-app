//
//  AlbumLibraryScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-21.
//

import SwiftUI
import MusicKit

struct AlbumLibraryScreen: View {

    typealias SectionedALbumLibrary = [Dictionary<String.Element, [MusicItemCollection<Album>.Element]>.Element]

    @Environment(NavPath.self) private var navigation
    @State private var albums: SectionedALbumLibrary?

    @State private var searchText: String = ""

    private var count: Int = 2
    private var gutters: CGFloat = 12

    private var gridColumns: [GridItem] {
        Array(repeating: .init(spacing: gutters), count: count)
    }

    private var spacing: CGFloat {
        gutters * CGFloat(count)
    }

    var body: some View {

        GeometryReader {

            let cellWidth = ($0.size.width / CGFloat(count)) - spacing

            ScrollView {

                albumSections(cellWidth)
            }
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            .contentMargins([.horizontal, .top], gutters)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        .navigationTitle("Albums")
        .task { await loadAlbums() }

    }

    @ViewBuilder
    private func albumSections(_ cellWidth: CGFloat) -> some View {

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
                        ForEach(value, id: \.self) { item in
                            AlbumItemCell(item: item, size: cellWidth)
                                .onTapGesture {
                                    navigation.path.append(AppRootScreen.DetailsView.album(item))
                                }
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }
    }
}

extension AlbumLibraryScreen {

    private func loadAlbums() async {

        do {

            var request = MusicLibraryRequest<Album>()
            request.sort(by: \.artistName, ascending: true)

            let response = try await request.response()

            let sections = Dictionary(grouping: response.items) { $0.artistName.first ?? "?" }
            let ordered = sections.sorted( by: { $0.0 < $1.0 })

            updateAlbums(with: ordered)
        } catch {
            print("Can't load albums with: \(error)")
        }
    }

    @MainActor
    private func updateAlbums(with response: SectionedALbumLibrary?) {
        self.albums = response
    }
}

