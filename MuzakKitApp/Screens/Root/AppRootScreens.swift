//
//  AppRootScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit

enum AppRootScreen: Hashable, CaseIterable, Identifiable {

    case browse
    case library
    case search

    var id: AppRootScreen { self }

    enum LibraryList: String, CaseIterable, Identifiable {

        case playlists
        case artists
        case albums
        case songs
        case genres

        var id: String { self.rawValue }

        var title: String { self.rawValue.capitalized }

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

    enum DetailsView: Hashable, Identifiable {

        case album(_ album: Album)
        case playlist(_ playlist: Playlist)
        case artist(_ artist: Artist)
        case genre(_ genre: Genre)
        case artistLibrary(_ library: MusicLibrarySection<Artist, Album>)

        var id: DetailsView { self }
    }
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
                BrowseScreen()
            }
        case .library:
            AppRootNavigation {
                LibraryScreen()
            }

        case .search:
            AppRootNavigation {
                SearchScreen()
            }
        }
    }
}

extension AppRootScreen.LibraryList {

    @ViewBuilder
    var destination: some View {
        switch self {
        case .playlists: PlaylistLibraryScreen()
        case .artists: ArtistLibraryScreen()
        case .albums: AlbumLibraryScreen()
        case .songs: Text(self.title)
        case .genres: Text(self.title)
        }
    }
}

extension AppRootScreen.DetailsView {

    @ViewBuilder
    var destination: some View {
        switch self {
        case .album(let album): AlbumDetailScreen(album: album)
        case .playlist(let playlist): PlaylistDetailScreen(playlist: playlist)
        case .artist(let artist): ArtistPageScreen(artist: artist)
        case .genre(let genre): GenreScreen(genre: genre)
        case .artistLibrary(let library): ArtistLibraryDetailsScreen(details: library)
        }
    }
}
