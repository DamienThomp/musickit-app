//
//  MiniMusicPlayer.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-12.
//

import SwiftUI
import MusicKit

struct MiniMusicPlayer: View {

    @Environment(MusicPlayerService.self) var musicPlayer

    @Binding var toggleView: Bool

    let nameSpace: Namespace.ID

    var body: some View {
        
            HStack(spacing: 12) {

                if let artwork = musicPlayer.currentItem?.artwork {
                    ArtworkImage(artwork, width: 34, height: 34)
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.coverImage.name, in: nameSpace)
                        .frame(width: 34, height: 34)
                        .artworkCornerRadius(.small)
                        .onTapGesture {
                            withAnimation(PlayerMatchedGeometry.animation) {
                                toggleView.toggle()
                            }
                        }
                } else {
                    Rectangle()
                        .fill(.secondary)
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.coverImage.name, in: nameSpace)
                        .frame(width: 34, height: 34)
                        .artworkCornerRadius(.small)
                        .onTapGesture {
                            withAnimation(PlayerMatchedGeometry.animation) {
                                toggleView.toggle()
                            }
                        }
                }

                VStack(alignment: .leading) {
                    
                    if let title = musicPlayer.currentItem?.title {
                        Text(title)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .matchedGeometryEffect(id: PlayerMatchedGeometry.title.name, in: nameSpace)
                    }

                    if let subtitle = musicPlayer.currentItem?.subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .matchedGeometryEffect(id: PlayerMatchedGeometry.subtitle.name, in: nameSpace)
                    }
                }

                Spacer()

                HStack(spacing: 20) {
                    
                    Button {
                        musicPlayer.togglePlayBack()
                    } label: {
                        Image(systemName: musicPlayer.playbackState == .playing ? Symbols.pause.name : Symbols.play.name)
                            .imageScale(.large)
                            .font(.system(size: 20))
                            .foregroundStyle(.pink)
                    }.matchedGeometryEffect(id: PlayerMatchedGeometry.primaryAction.name, in: nameSpace)

                    Button {
                        musicPlayer.skipToNext()
                    } label: {
                        Symbols.skipForward.image
                            .imageScale(.large)
                            .font(.system(size: 20))
                            .foregroundStyle(.pink)

                    }.matchedGeometryEffect(id: PlayerMatchedGeometry.secondaryAction.name, in: nameSpace)
                }
            }
            .padding(10)
            .padding(.trailing, 6)
            .background(
                Rectangle()
                    .fill(Color(.systemGray5))
                    .matchedGeometryEffect(id: PlayerMatchedGeometry.background.name, in: nameSpace)
            )
            .artworkCornerRadius(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {

    @Previewable @Namespace var nameSpace
    @Previewable @State var toggle = false

    MiniMusicPlayer(toggleView: $toggle ,nameSpace: nameSpace)
        .environment(MusicPlayerService())
}
