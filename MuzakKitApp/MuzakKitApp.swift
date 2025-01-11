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
    let navigation: NavPath

    @State private var selection: AppRootScreen = .browse

    init() {
        self.musicPlayerManager = MusicPlayerManager()
        self.navigation = NavPath()
    }

    var body: some Scene {

        WindowGroup {
            AppRootView(selection: $selection)
                .environment(musicPlayerManager)
                .environment(navigation)
        }
    }
}
