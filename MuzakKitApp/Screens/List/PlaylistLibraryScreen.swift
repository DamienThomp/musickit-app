//
//  PlaylistLibraryScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-20.
//

import SwiftUI
import MusicKit

struct PlaylistLibraryScreen: View {

    @Environment(NavPath.self) private var navigation
    @State private var playlists: MusicItemCollection<Playlist>?

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

                if let playlists = playlists, !playlists.isEmpty {

                    LazyVGrid(
                        columns: gridColumns,
                        alignment: .center,
                        spacing: spacing
                    ) {
                        ForEach(playlists, id: \.self) { item in
                            PlaylistItemCell(item: item, size: cellWidth)
                                .onTapGesture {
                                    navigation.path.append(AppRootScreen.DetailsView.playlist(item))
                                }
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            .contentMargins([.horizontal, .top], gutters)
        }
        .navigationTitle("Playlists")
        .task { loadPlaylists() }

    }
}

extension PlaylistLibraryScreen {

    private func loadPlaylists() {

        Task {
            do {
                var request = MusicLibraryRequest<Playlist>()
                request.limit = 25
                let response = try await request.response()
                updatePlaylists(with: response.items)
            } catch {
                print("Can't load playlists with: \(error.localizedDescription)")
            }
        }
    }

    private func loadNextBatch() {

        guard let playlists = self.playlists,
              playlists.hasNextBatch else { return }
        Task {
            do {
                guard let response = try await playlists.nextBatch() else { return }
                // updatePlaylists(with: response)
            } catch {
                print("Can't load next batch with: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    private func updatePlaylists(with response: MusicItemCollection<Playlist>) {
        self.playlists = response
    }
}
