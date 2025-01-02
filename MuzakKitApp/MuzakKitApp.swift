//
//  MuzakKitApp.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-22.
//

import SwiftUI
import MusicKit

@main
struct MuzakKitApp: App {

    let musicPlayerManager: MusicPlayerManager

    init() {
        self.musicPlayerManager = MusicPlayerManager()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
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
            }
            .tint(.pink)
            .environment(musicPlayerManager)
        }
    }
}
