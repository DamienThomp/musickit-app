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

    var body: some View {

        HStack {

            if let artwork = item?.artwork {

                ArtworkImage(artwork, width: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay {
                        if isActiveTrack && isPlaying {
                            VStack {
                                Image(systemName: "waveform")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .symbolEffect(.variableColor.iterative, options: .repeating, value: animateIcon)
                                    .foregroundStyle(.primary)
                                    .onAppear {
                                        animateIcon.toggle()
                                    }
                            }
                            .padding()
                            .frame(width: 50, height: 50)
                            .background(.black.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
            }

            VStack(alignment: .leading) {

                Text(item?.title ?? "Song Title")
                    .foregroundStyle(isActiveTrack ? .pink : .primary)
                Text(item?.artistName ?? "Artist Name")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                Divider()
            }
            .lineLimit(1)
            .multilineTextAlignment(.leading)
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
    .frame(height: 50)
    .preferredColorScheme(.dark)
}
