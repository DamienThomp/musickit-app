//
//  AppRootNavigation.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit
import Observation

@Observable
class NavPath {
    var path: NavigationPath = NavigationPath()
}

struct AppRootNavigation<Content: View>: View {

    @ViewBuilder let content: Content
    @Environment(NavPath.self) private var navigation

    var body: some View {

        @Bindable var navigation = navigation

        NavigationStack(path: $navigation.path) {
            content
                .navigationDestination(for: Album.self) { item in
                    AlbumDetailScreen(album: item)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .navigationDestination(for: Playlist.self) { item in
                    PlaylistDetailScreen(playlist: item)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .navigationDestination(for: Artist.self) { item in
                    ArtistPageScreen(artist: item)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .navigationDestination(for: Genre.self) { item in
                    GenreView(genre: item).navigationTitle("Genre: \(item.name)")
                }
        }.tint(.pink)
    }
}
