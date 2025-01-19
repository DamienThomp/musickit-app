//
//  MusicKitService.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-18.
//

import Foundation
import SwiftUI
import MusicKit
import Observation

@Observable
class MusicKitService {

    var authStatus: MusicAuthorization.Status = MusicAuthorization.currentStatus
    var subscription: MusicSubscription?

    init() {
        listeForSubscriptionUpdates()
        checkAuthStatus()
    }

    private func checkAuthStatus() {

        guard authStatus == .notDetermined else { return }

        Task {
            let status = await MusicAuthorization.request()
            await updateAuthStatus(with: status)
        }
    }

    private func listeForSubscriptionUpdates() {
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

// MARK: - Public methods
extension MusicKitService {

    func getData<T: MusicItem & Decodable & MusicPropertyContainer>(
        for item: T,
        with properties: [PartialMusicAsyncProperty<T>]
    ) async throws -> T {

        let response = try await item.with(properties)

        return response
    }

    func addToLibrary<T>(_ item: T) async throws where T: MusicItem, T: MusicLibraryAddable {

        let library = MusicLibrary.shared

        try await library.add(item)
    }

    func isInLirabry<T: MusicItem>(_ item: T) async throws -> Bool  {

        if let item = item as? Album {
            return try await checkLibraryStatus(for: item)
        }

        if let item = item as? Playlist {
            return try await checkLibraryStatus(for: item)
        }

        if let item = item as? Song {
            return try await checkLibraryStatus(for: item)
        }

        if let item = item as? Track {
            return try await checkLibraryStatus(for: item)
        }
        
        return false
    }

    func checkLibraryStatus(for item: Album) async throws -> Bool {

        var request = MusicLibraryRequest<Album>()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return !response.items.isEmpty
    }

    func checkLibraryStatus(for item: Song) async throws -> Bool {

        var request: MusicLibraryRequest<Song> = MusicLibraryRequest()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return !response.items.isEmpty
    }

    func checkLibraryStatus(for item: Track) async throws -> Bool {

        var request: MusicLibraryRequest<Track> = MusicLibraryRequest()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return !response.items.isEmpty
    }


    func checkLibraryStatus(for item: Playlist) async throws -> Bool {

        var request: MusicLibraryRequest<Playlist> = MusicLibraryRequest()
        request.filter(matching: \.id, equalTo: item.id)

        let response = try await request.response()

        return !response.items.isEmpty
    }
}
