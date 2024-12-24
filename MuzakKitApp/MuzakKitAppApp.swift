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
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationDestination(for: MusicPersonalRecommendation.Item.self) { item in
                        switch item.self {
                        case .album(let album):
                            AlbumDetailScreen(album: album)
                        case .playlist(let playlist):
                            Text("playlist \(playlist.name)")
                        case .station(let station):
                            Text("station: \(station.name)")
                        @unknown default:
                            Text("Unknown type")
                        }
                    }
            }
        }
    }
}
