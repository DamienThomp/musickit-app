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

    let auth: MusicAuthorizationProvider
    let dataFetching: MusicDataFetching
    let search: MusicSearchProvider
    let library: MusicLibraryProvider

    var authStatus: MusicAuthorization.Status = MusicAuthorization.currentStatus
    var subscription: MusicSubscription?

    var presentPlaylistform: Bool = false
    var itemToAdd: MusicPlaylistAddable?

    init(
        auth: MusicAuthorizationProvider,
        dataFetching: MusicDataFetching,
        search: MusicSearchProvider,
        library: MusicLibraryProvider
    ) {

        self.auth = auth
        self.dataFetching = dataFetching
        self.search = search
        self.library = library

        listenForSubscriptionUpdates()
        checkAuthStatus()
    }

    private func checkAuthStatus() {

        guard authStatus == .notDetermined else { return }

        Task {

            let status = await auth.requestAuthorization()
            await updateAuthStatus(with: status)
        }
    }

    private func listenForSubscriptionUpdates() {

        Task {

            for await subscription in auth.subscriptionUpdates {
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

// MARK: - Playlist
extension MusicKitService {

    func presentAddToPlaylistForm<T>(for item: T) where T: MusicPlaylistAddable {
        presentPlaylistform = true
        itemToAdd = item
    }
}
