//
//  MusicPlayerManager.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-28.
//

import Foundation
import MusicKit
import Observation

@Observable
class MusicPlayerManager {

    private let player = ApplicationMusicPlayer.shared

    var playerState = ApplicationMusicPlayer.shared.state

    var isPlaying: Bool {
        return (playerState.playbackStatus == .playing)
    }

    func handleTrackSelected(for track: Track, from loadedTracks: MusicItemCollection<Track>) {
        player.queue = .init(for: loadedTracks, startingAt: track)
        beginPlaying()
    }

    func handlePlayback(for items: PlayableMusicItem) {
        player.queue = [items]
        beginPlaying()
    }

    func togglePlayBack() {

        if isPlaying {
            player.pause()
        } else {
            beginPlaying()
        }
    }

    func shufflePlayback(for items: PlayableMusicItem) {

        toggleSuffleState()
        player.queue = [items]
        beginPlaying()
    }

    private func toggleSuffleState() {

        if isPlaying {
            player.pause()
        }

        if playerState.shuffleMode == .off {
            playerState.shuffleMode = .songs
        } else {
            playerState.shuffleMode = .off
        }
    }

    private func beginPlaying() {
        Task {
            do {
                try await player.play()
            } catch {
                print("Failed to begin playback with error: \(error).")
            }
        }
    }
}
