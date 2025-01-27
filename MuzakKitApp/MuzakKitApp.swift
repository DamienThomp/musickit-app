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

    let musicKitSercice: MusicKitService
    let musicPlayerManager: MusicPlayerService
    let navigation: NavPath

    @State private var selection: AppRootScreen = .browse

    init() {
        self.musicKitSercice = MusicKitService()
        self.musicPlayerManager = MusicPlayerService()
        self.navigation = NavPath()
    }

    var body: some Scene {

        WindowGroup {
            AppRootView(selection: $selection)
                .preferredColorScheme(.dark)
                .environment(musicKitSercice)
                .environment(musicPlayerManager)
                .environment(navigation)
        }
    }
}
