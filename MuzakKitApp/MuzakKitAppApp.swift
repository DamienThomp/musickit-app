//
//  MuzakKitAppApp.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-22.
//

import SwiftUI
import MusicKit

@main
struct MuzakKitAppApp: App {
    let musicPlayerManager: MusicPlayerManager

    init() {
        self.musicPlayerManager = MusicPlayerManager()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationDestination(for: MusicPersonalRecommendation.Item.self) { item in
                        switch item.self {
                        case .album(let album):
                            AlbumDetailScreen(album: album)
                        case .playlist(let playlist):
                            PlaylistDetailScreen(playlist: playlist)
                        case .station(let station):
                            Text("station: \(station.name)")
                        @unknown default:
                            Text("Unknown type")
                        }
                    }
            }
            .tint(.pink)
            .environment(musicPlayerManager)
        }
    }
}
