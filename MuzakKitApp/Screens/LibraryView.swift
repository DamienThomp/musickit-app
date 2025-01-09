//
//  LibraryView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-06.
//

import SwiftUI
import MusicKit


struct LibraryView: View {

    @State var items: MusicItemCollection<Album>? = nil

    var body: some View {

        GeometryReader { geometry in

            List {

                ForEach(LibraryList.allCases, id: \.id) { item in

                    NavigationLink {
                        Text(item.title)
                    } label: {
                        HStack {
                            Image(systemName: item.icon)
                                .frame(minWidth: 30)
                                .imageScale(.large)
                                .foregroundStyle(.pink)
                                .padding(.horizontal, 6)
                            Text(item.title).font(.title2)
                        }
                    }
                }

                if let items = items {

                    Text("Recently Added")
                        .textStyle(SectionHeaderStyle())
                        .padding(.top, 14)

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
        }.navigationTitle("Library")
    }
}

extension LibraryView {

    enum LibraryList: String, CaseIterable, Identifiable {

        case playlists
        case artists
        case albums
        case songs
        case genres

        var id: String {
            self.rawValue
        }

        var title: String {
            self.rawValue.capitalized
        }

        var icon: String {

            switch self {
            case .playlists:
                "music.note.list"
            case .artists:
                "music.mic"
            case .albums:
                "square.stack"
            case .songs:
                "music.note"
            case .genres:
                "guitars"
            }
        }
    }

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

#Preview {
    NavigationStack {
        LibraryView(items: albumitems)
    }
}
