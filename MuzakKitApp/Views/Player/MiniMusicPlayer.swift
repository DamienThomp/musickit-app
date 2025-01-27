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

    private var title: String {
        musicPlayer.currentItem?.title ?? "Song Title"
    }

    private var subtitle: String {
        musicPlayer.currentItem?.subtitle ?? "Album Name"
    }

    private var artwork: Artwork? {
        musicPlayer.currentItem?.artwork
    }

    var body: some View {

        HStack(spacing: 12) {

            playerArtwork()

            playerInfo

            Spacer()

            playerActions

        }
        .padding(10)
        .padding(.trailing, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Rectangle()
                .fill(Color(.systemGray5))
                .matchedGeometryEffect(
                    id: PlayerMatchedGeometry.background.name,
                    in: nameSpace
                )
        )
        .artworkCornerRadius(.medium)
        .padding(8)
    }

    @ViewBuilder
    private func playerArtwork() -> some View {

        if let artwork {
            ArtworkImage(artwork, width: 34, height: 34)
                .matchedGeometryEffect(
                    id: PlayerMatchedGeometry.coverImage.name,
                    in: nameSpace
                )
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
                .matchedGeometryEffect(
                    id: PlayerMatchedGeometry.coverImage.name,
                    in: nameSpace
                )
                .frame(width: 34, height: 34)
                .artworkCornerRadius(.small)
                .onTapGesture {
                    withAnimation(PlayerMatchedGeometry.animation) {
                        toggleView.toggle()
                    }
                }
        }
    }

    private var playerInfo: some View {
        VStack {
            Text(title)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .matchedGeometryEffect(
                    id: PlayerMatchedGeometry.title.name,
                    in: nameSpace
                )


            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .matchedGeometryEffect(
                    id: PlayerMatchedGeometry.subtitle.name,
                    in: nameSpace
                )
        }
    }

    private var playerActions: some View {

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
}

#Preview(traits: .sizeThatFitsLayout) {

    @Previewable @Namespace var nameSpace
    @Previewable @State var toggle = false

    MiniMusicPlayer(toggleView: $toggle ,nameSpace: nameSpace)
        .environment(MusicPlayerService())
}
