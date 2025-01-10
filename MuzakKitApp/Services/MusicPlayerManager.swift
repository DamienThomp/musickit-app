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
        let item = player.queue.currentEntry
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

    func playNext(_ track: Track? = nil, _ loadedTracks: MusicItemCollection<Track>? = nil) {

        if let track,
           let loadedTracks,
           let index = loadedTracks.firstIndex(where: { $0.id == track.id }) {

            if index < loadedTracks.count - 1 {
                let nextIndex = loadedTracks.index(after: index)
                let nextItem = loadedTracks[nextIndex]

                player.queue = .init(for: loadedTracks, startingAt: nextItem)
                beginPlaying()
            }
        } else {
            skipToNext()
        }
    }

    func playLast() {
        //TODO: - add condition for first play where queue is empty
        guard player.isPreparedToPlay, !player.queue.entries.isEmpty else { return }

        let lastTrack = player.queue.entries.last
        let entries = player.queue.entries
        player.queue = .init(entries, startingAt: lastTrack)

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

    func skipToPrevious() {

        Task {
            do {
                try await player.skipToPreviousEntry()
            } catch {
                print("Failed to play previous track with error: \(error).")
            }
        }
    }

    func skipToNext() {

        Task {
            do {
                try await player.skipToNextEntry()
            } catch {
                print("Failed to play next track with error: \(error).")
            }
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
