//
//  LibraryView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-06.
//

import SwiftUI
import MusicKit


struct LibraryView: View {

    @State private var items: MusicItemCollection<Album>?

    var body: some View {

        GeometryReader { geometry in

            List {

                if let items = items {

                    Text("Recently Added")
                        .textStyle(SectionHeaderStyle())

                    LazyVGrid(
                        columns: [
                            GridItem(spacing: 12),
                            GridItem(spacing: 12)
                        ],alignment: .center,
                        spacing: 24
                    ) {
                        ForEach(items, id: \.self) { item in
                            AlbumItemCell(item: item, size: (geometry.size.width / 2) - 24)
                        }
                    }

                }
            }.listStyle(.plain)
        }.task {
            try? await loadRecentlyAdded()
        }
    }
}

extension LibraryView {

    private func loadRecentlyAdded() async throws {

        var request: MusicLibraryRequest<Album> = MusicLibraryRequest()
        request.limit = 25
        request.sort(by: \.libraryAddedDate, ascending: false)

        let albumResponse = try await request.response()
        updateSection(with: albumResponse.items)
    }

    @MainActor
    private func updateSection(with albums: MusicItemCollection<Album>) {
        withAnimation {
            self.items = albums
        }
    }
}
