//
//  AppRootScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI

enum AppRootScreen: Hashable, CaseIterable, Identifiable {

    case browse
    case library
    case search

    var id: AppRootScreen { self }
}

extension AppRootScreen {

    @ViewBuilder
    var label: some View {
        switch self {
        case .browse:
            Label("Browse", systemImage: "square.grid.2x2.fill")
        case .library:
            Label("Library", systemImage: "music.note.list")
        case .search:
            Label("Search", systemImage: "magnifyingglass")
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .browse:
            AppRootNavigation {
                BrowseView()
            }
        case .library:
            AppRootNavigation {
                LibraryView()
            }

        case .search:
            AppRootNavigation {
                Text("Search").navigationTitle("Search Catalog")
            }
        }
    }
}
