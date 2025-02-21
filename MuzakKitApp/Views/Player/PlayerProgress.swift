//
//  PlayerProgress.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-02-21.
//

import SwiftUI

struct PlayerProgress: View {

    @Environment(MusicPlayerService.self) var musicPlayerManager

    let duration: TimeInterval

    private var progress: TimeInterval {

        if let progress = musicPlayerManager.currentPlayBackTime,
           progress < duration {
            return progress
        }

        return 0.0
    }

    private var remaining: TimeInterval {

        return -(duration) + progress
    }

    var body: some View {

        Group {

            ProgressView(value: progress, total: duration)

            HStack {
                Text(progress, format: .duration(style: .positional))
                    .font(.caption)

                Spacer()
                Text(remaining, format: .duration(style: .positional))
                    .font(.caption)
            }
        }
    }
}
