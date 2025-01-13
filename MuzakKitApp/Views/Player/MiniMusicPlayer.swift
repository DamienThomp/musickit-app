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
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                } else {
                    Rectangle()
                        .frame(width: 34, height: 34)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }

                VStack(alignment: .leading) {
                    
                    if let title = musicPlayerManager.currentItem?.title {
                        Text(title)
                            .lineLimit(1)
                    }

                    if let subtitle = musicPlayerManager.currentItem?.subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer()

                HStack(spacing: 20) {
                    
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
                        Image(systemName: "forward.fill")
                            .imageScale(.large)
                            .font(.system(size: 20))
                            .foregroundStyle(.pink)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .padding(.trailing, 6)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MiniMusicPlayer()
        .environment(MusicPlayerManager())
}
