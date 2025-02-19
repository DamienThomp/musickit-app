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
        case genres

        var id: String { self.rawValue }

        var title: String { self.rawValue.capitalized }

        var icon: String {

            switch self {
            case .playlists:
                Symbols.musicNoteList.name
            case .artists:
                Symbols.musicMic.name
            case .albums:
                Symbols.squareStack.name
            case .genres:
                Symbols.guitars.name
            }
        }
    }

    enum DetailsView: Hashable, Identifiable {

        case album(_ album: Album)
        case playlist(_ playlist: Playlist)
        case artist(_ artist: Artist)
        case genre(_ genre: Genre)
        case artistLibrary(_ library: MusicLibrarySection<Artist, Album>)
        case genreLibrary(_ library: MusicLibrarySection<Genre, Album>)

        var id: DetailsView { self }
    }
}

extension AppRootScreen {

    @ViewBuilder
    var label: some View {
        switch self {
        case .browse:
            Label("Browse", systemImage: Symbols.browse.name)
        case .library:
            Label("Library", systemImage: Symbols.musicNoteList.name)
        case .search:
            Label("Search", systemImage: Symbols.search.name)
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
        case .genres: GenreLibraryScreen()
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
        case .genreLibrary(let library): GenreLibraryDetailsScreen(details: library)
        }
    }
}
