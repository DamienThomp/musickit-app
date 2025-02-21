//
//  MusicKitService.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-18.
//

import Foundation
import SwiftUI
import MusicKit

@Observable
class MusicKitService {

    var authStatus: MusicAuthorization.Status = MusicAuthorization.currentStatus
    var subscription: MusicSubscription?

    var presentPlaylistform: Bool = false
    var itemToAdd: MusicPlaylistAddable?

    init() {
        listenForSubscriptionUpdates()
        checkAuthStatus()
    }

    private func checkAuthStatus() {

        guard authStatus == .notDetermined else { return }

        Task {

            let status = await MusicAuthorization.request()
            await updateAuthStatus(with: status)
        }
    }

    private func listenForSubscriptionUpdates() {

        Task {

            for await subscription in MusicSubscription.subscriptionUpdates {
                await updateSubscription(with: subscription)
            }
        }
    }

    @MainActor
    private func updateSubscription(with subscription: MusicSubscription) {
        self.subscription = subscription
    }

    @MainActor
    private func updateAuthStatus(with status: MusicAuthorization.Status) {
        self.authStatus = status
    }
}

// MARK: - MusicItem with Properties
extension MusicKitService {

    func getData<T: MusicItem & Decodable & MusicPropertyContainer>(
        for item: T,
        with properties: [PartialMusicAsyncProperty<T>]
    ) async throws -> T {

        let response = try await item.with(properties)

        return response
    }
}

// MARK: - Library
extension MusicKitService {

    func addToLibrary<T>(_ item: T) async throws where T: MusicItem, T: MusicLibraryAddable {

        let library = MusicLibrary.shared

        try await library.add(item)
    }

    func isInLirabry<T: MusicItem>(_ item: T) async throws -> Bool {

        if let item = item as? Album {
            let response = try await libraryRequest(for: item)
            return !response.items.isEmpty
        }

        if let item = item as? Playlist {
            let response = try await libraryRequest(for: item)
            return !response.items.isEmpty
        }

        if let item = item as? Song {
            let response = try await libraryRequest(for: item)
            return !response.items.isEmpty
        }

        if let item = item as? Track {
            let response = try await libraryRequest(for: item)
            return !response.items.isEmpty
        }
        return false
    }

    func libraryRequest(for item: Album) async throws -> MusicLibraryResponse<Album> {

        var request = MusicLibraryRequest<Album>()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return response
    }

    func libraryRequest(for item: Song) async throws -> MusicLibraryResponse<Song> {

        var request: MusicLibraryRequest<Song> = MusicLibraryRequest()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return response
    }

    func libraryRequest(for item: Track) async throws -> MusicLibraryResponse<Track> {

        var request: MusicLibraryRequest<Track> = MusicLibraryRequest()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return response
    }

    func libraryRequest(for item: Playlist) async throws -> MusicLibraryResponse<Playlist> {

        var request: MusicLibraryRequest<Playlist> = MusicLibraryRequest()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return response
    }
}

// MARK: - Search
extension MusicKitService {

    func search(with searchText: String) async throws -> MusicCatalogSearchResponse {

        let searchRequest = MusicCatalogSearchRequest(
            term: searchText,
            types: [
                Album.self,
                Song.self,
                Playlist.self,
                Station.self,
                Artist.self
            ]
        )

        let response = try await searchRequest.response()

        return response
    }

    func search(
        with searchText: String,
        for types: [any MusicLibrarySearchable.Type]
    ) async throws -> MusicLibrarySearchResponse {
        
        let searchRequest = MusicLibrarySearchRequest(term: searchText, types: types)

        let response = try await searchRequest.response()

        return response
    }
}

// MARK: - Playlist
extension MusicKitService {

    func presentAddToPlaylistForm<T>(for item: T) where T: MusicPlaylistAddable {
        presentPlaylistform = true
        itemToAdd = item
    }
}
