//
//  SongItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-19.
//

import SwiftUI
import MusicKit

struct SongItemCell: View {

    @Environment(MusicPlayerService.self) private var musicPlayer

    let item: Song?
    let width: CGFloat

    @State var animateIcon: Bool = false
    @State var animateBackground: Bool = false

    private var isActiveTrack: Bool {
        guard let item,
              let currentItem = musicPlayer.currentItem,
              let currentID = currentItem.item?.id else { return false }

        return item.id == currentID
    }

    private var isPlaying: Bool {
        return musicPlayer.playbackState == .playing
    }

    private var imageWidth: CGFloat {
        width / 8
    }

    var body: some View {

        HStack {

            songArtwork()
                .overlay {
                    artworkOverlay()
                }

            VStack(alignment: .leading) {

                songInfo

                Divider()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.2)) {
                    animateBackground = true
                } completion: {
                    withAnimation(.easeOut(duration: 0.2)) {
                        animateBackground = false
                    }
                }
            }

            Spacer()
        }
        .padding(.vertical, 4)
        .frame(width: width)
        .background(animateBackground ? Color(.systemGray4) : .clear)
    }

    @ViewBuilder
    private var songInfo: some View {

        Group {

            Text(item?.title ?? "Song Title")
                .foregroundStyle(isActiveTrack ? .pink : .primary)

            Text(item?.artistName ?? "Artist Name")
                .font(.caption)
                .foregroundStyle(Color.secondary)
        }
        .lineLimit(1)
        .multilineTextAlignment(.leading)
    }

    @ViewBuilder
    private func songArtwork() -> some View {

        if let artwork = item?.artwork {

            ArtworkImage(artwork, width: imageWidth)
                .artworkCornerRadius(.medium)


        } else {

            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray3))
                .frame(width: imageWidth, height: imageWidth)
                .artworkCornerRadius(.medium)
        }
    }

    @ViewBuilder
    private func artworkOverlay() -> some View {

        if isActiveTrack && isPlaying {
            VStack {
                Symbols.waveform.image
                    .resizableImage()
                    .symbolEffect(
                        .variableColor.iterative,
                        options: .repeating,
                        value: animateIcon
                    )
                    .foregroundStyle(.primary)
                    .onAppear {
                        animateIcon = true
                    }
            }
            .padding()
            .frame(width: imageWidth, height: imageWidth)
            .background(.black.opacity(0.5))
            .artworkCornerRadius(.medium)
        }
    }
}

#Preview {
    VStack {
        GeometryReader {
            let width = $0.size.width
            SongItemCell(item: nil, width: width)
                .environment(MusicPlayerService())
        }
    }
    .frame(maxWidth: .infinity)
    .preferredColorScheme(.dark)
}
