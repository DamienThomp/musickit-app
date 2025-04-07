//
//  MusicKitAuthService.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-04-06.
//

import MusicKit

class MusicKitAuthService: MusicAuthorizationProvider {

    var currentStatus: MusicAuthorization.Status {
        return MusicAuthorization.currentStatus
    }

    var subscriptionUpdates: MusicSubscription.Updates {
        return MusicSubscription.subscriptionUpdates
    }

    func requestAuthorization() async -> MusicAuthorization.Status {
        return await MusicAuthorization.request()
    }
}
