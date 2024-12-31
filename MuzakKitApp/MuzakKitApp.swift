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
//                    .navigationDestination(for: MusicPersonalRecommendation.Item.self) { item in
//                        switch item.self {
//                        case .album(let album):
//                            AlbumDetailScreen(album: album)
//                                .navigationBarTitleDisplayMode(.inline)
//                        case .playlist(let playlist):
//                            PlaylistDetailScreen(playlist: playlist)
//                                .navigationBarTitleDisplayMode(.inline)
//                        case .station(let station):
//                            Text("Play station \(station.description)")
//                        @unknown default:
//                            Text("Unknown type")
//                        }
//                    }
                    .navigationDestination(for: Album.self) { item in
                        AlbumDetailScreen(album: item)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .navigationDestination(for: Playlist.self) { item in
                        PlaylistDetailScreen(playlist: item)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .navigationDestination(for: Artist.self) { item in
                        Text("Artist page for \(item.name)")
                    }
            }
            .tint(.pink)
            .environment(musicPlayerManager)
        }
    }
}
