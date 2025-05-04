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
    @Environment(MusicPlayerService.self) private var musicPlayer
    @Environment(MusicKitService.self) private var musicKitService
    @Environment(\.navigationNamespace) private var navigationNamespace

    var body: some View {

        @Bindable var navigation = navigation

        NavigationStack(path: $navigation.path) {
            content
                .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                .navigationDestination(for: Album.self) { item in
                    if #available(iOS 18.0, *) {
                        AlbumDetailScreen(album: item)
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                            .navigationTransition(.zoom(sourceID: item.id, in: navigationNamespace!))
                    } else {
                        AlbumDetailScreen(album: item)
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                    }
                }
                .navigationDestination(for: Playlist.self) { item in
                    if #available(iOS 18.0, *) {
                        PlaylistDetailScreen(playlist: item)
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                            .navigationTransition(.zoom(sourceID: item.id, in: navigationNamespace!))
                    } else {
                        PlaylistDetailScreen(playlist: item)
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                    }
                }
                .navigationDestination(for: Artist.self) { item in
                    if #available(iOS 18.0, *) {
                        ArtistPageScreen(artist: item)
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                            .navigationTransition(.zoom(sourceID: item.id, in: navigationNamespace!))
                    } else {
                        ArtistPageScreen(artist: item)
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                    }
                }
                .navigationDestination(for: Genre.self) { item in
                    GenreScreen(genre: item)
                        .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                }
                .navigationDestination(for: AppRootScreen.DetailsView.self) { item in
                    if #available(iOS 18.0, *) {
                        item.destination
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                            .navigationTransition(.zoom(sourceID: item.id, in: navigationNamespace!))
                    } else {
                        item.destination
                            .navigationBarTitleDisplayMode(.inline)
                            .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                    }
                }
                .navigationDestination(for: AppRootScreen.LibraryList.self) { item in
                    item.destination
                        .navigationBarTitleDisplayMode(.inline)
                        .safeAreaPadding(.bottom, musicPlayer.hasQueue ? 60 : 0)
                }
        }.tint(.pink)
    }
}
