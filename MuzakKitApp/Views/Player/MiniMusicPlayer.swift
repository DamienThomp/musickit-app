//
//  MiniMusicPlayer.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-12.
//

import SwiftUI
import MusicKit

struct MiniMusicPlayer: View {

    @Environment(MusicPlayerManager.self) var musicPlayerManager

    var body: some View {

            HStack(spacing: 12) {

                if let artwork = musicPlayerManager.currentItem?.artwork {
                    ArtworkImage(artwork, width: 34, height: 34)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    Rectangle()
                        .frame(width: 34, height: 34)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                if let title = musicPlayerManager.currentItem?.title {
                    Text(title)
                        .lineLimit(1)
                }

                Spacer()

                Button {
                    musicPlayerManager.togglePlayBack()
                } label: {
                    Image(systemName: musicPlayerManager.playbackState == .playing ? "pause.fill" : "play.fill")
                        .imageScale(.large)
                        .font(.system(size: 20))
                        .foregroundStyle(.pink)
                }

                Button {
                    musicPlayerManager.skipToNext()
                } label: {
                    Image(systemName: "forward.end.fill")
                        .imageScale(.large)
                        .font(.system(size: 20))
                        .foregroundStyle(.pink)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .offset(y: -48)
    }
}

#Preview {
    MiniMusicPlayer()
        .environment(MusicPlayerManager())
}
