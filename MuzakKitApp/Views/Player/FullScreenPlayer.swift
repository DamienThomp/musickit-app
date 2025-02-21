//
//  FullScreenPlayer.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-15.
//

import SwiftUI
import MusicKit

struct FullScreenPlayer: View {

    @Environment(MusicPlayerService.self) private var musicPlayer

    @Binding var toggleView: Bool

    @State private var volume = 0.5
    @State private var playerOffset = 0.0

    let proxy: GeometryProxy
    let nameSpace: Namespace.ID

    private let opacity: CGFloat = 0.9

    private var isPlaying: Bool {
        musicPlayer.playbackState == .playing
    }

    private var artwork: Artwork? {
        musicPlayer.artwork
    }

    private var hasBackground: Bool {
        artwork?.backgroundColor != nil
    }

    private var defaultBackground: Color {
        Color(.systemGray4)
    }

    private var background: Color {

        if let artworkBackground = artwork?.backgroundColor {
            return Color(cgColor: artworkBackground)
        }

        return Color(.systemGray4)
    }

    private var title: String {
        musicPlayer.currentItem?.title ?? "Song Title"
    }

    private var subtitle: String {
        musicPlayer.currentItem?.subtitle ?? "Album Name"
    }

    private var duration: Double? {

        guard let item = musicPlayer.currentItem?.item else { return nil }

        switch item {
        case .song(let song):
            return song.duration
        case .musicVideo(let musicVideo):
            return musicVideo.duration
        @unknown default:
            return nil
        }
    }

    private func handleProgressTimer(_ isDismissing: Bool = false) {

        guard !isDismissing else {
            musicPlayer.stopPlayBackTimer()
            return
        }

        switch musicPlayer.playbackState {
        case .playing:
            musicPlayer.startPlayBackTimer()
        default:
            musicPlayer.stopPlayBackTimer()
        }
    }

    var body: some View {

        let width = proxy.size.width - 48

        ZStack {

            playerBackground

            VStack {

                dragHandle

                playerArtwork(width)
                    .padding(.top, 14)
                    .padding(.bottom, 32)

                VStack {
                    playerInfo
                    playerControls
                    volumeSlider
                        .highPriorityGesture(DragGesture())
                        .opacity(opacity)
                }.padding(.horizontal, 8)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, proxy.safeAreaInsets.top)
        }
        .offset(y: toggleView ? playerOffset : .zero)
        .gesture(modalGesture)
    }

    private var modalGesture: some Gesture {
        
        DragGesture()
            .onChanged { gesture in

                let translationY = gesture.translation.height

                withAnimation {
                    playerOffset = (translationY > 0 ? translationY : 0)
                }
            }.onEnded { value in

                let velocity = CGSize(
                    width: value.predictedEndLocation.x - value.location.x,
                    height: value.predictedEndLocation.y - value.location.y
                )

                withAnimation {
                    if velocity.height > 500.0 {
                        toggleView.toggle()
                        playerOffset = .zero
                        return
                    }

                    if playerOffset > proxy.size.height /  3 {
                        toggleView.toggle()
                        playerOffset = .zero
                        return
                    }

                    playerOffset = .zero
                }
            }
    }

    @ViewBuilder
    private var playerBackground: some View {

        Rectangle()
            .fill(hasBackground ? background.gradient : defaultBackground.gradient)
            .matchedGeometryEffect(
                id: PlayerMatchedGeometry.background.name,
                in: nameSpace
            )
            .clipShape(RoundedRectangle(cornerRadius: proxy.safeAreaInsets.top - 10))
            .animation(.easeIn, value: hasBackground)
            .colorMultiply(Color(hue: 0.0, saturation: 0, brightness: 0.7))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }

    @ViewBuilder
    private var dragHandle: some View {

        Capsule()
            .fill(.secondary.opacity(opacity))
            .frame(width: 50, height: 5)
            .padding(.bottom)
            .onTapGesture {
                withAnimation(PlayerMatchedGeometry.animation) {
                    toggleView.toggle()
                }
            }
    }

    @ViewBuilder
    private func playerArtwork(_ width: CGFloat) -> some View {

        Group {

            if let artwork = artwork {

                ArtworkImage(artwork, width: width, height: width)
                    .matchedGeometryEffect(
                        id: PlayerMatchedGeometry.coverImage.name,
                        in: nameSpace
                    )
                    .frame(width: width, height: width)
                    .artworkCornerRadius(.large)
                    .shadow(
                        color: .black.opacity(0.2),
                        radius: 30,
                        y: 15
                    )
                    .scaleEffect(isPlaying ? 1 : 0.8)
                    .animation(
                        .interpolatingSpring(
                            duration: 0.5,
                            bounce: 0.5
                        ),
                        value: isPlaying
                    )
            } else {

                Rectangle()
                    .fill(.secondary)
                    .matchedGeometryEffect(
                        id: PlayerMatchedGeometry.coverImage.name,
                        in: nameSpace
                    )
                    .frame(width: width, height: width)
                    .artworkCornerRadius(.large)
                    .shadow(
                        color: .black.opacity(0.2),
                        radius: 30,
                        y: 15
                    )
            }
        }
    }

    private var playerInfo: some View {

        VStack {

            Group {

                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(
                        id: PlayerMatchedGeometry.title.name,
                        in: nameSpace
                    )

                Text(subtitle)
                    .font(.title3)
                    .foregroundStyle(.secondary.opacity(opacity))
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(
                        id: PlayerMatchedGeometry.subtitle.name,
                        in: nameSpace
                    )
                    .padding(.bottom, 20)
            }

            if let duration = duration {

                PlayerProgress(duration: duration)
                    .tint(.secondary)
                    .foregroundStyle(.secondary)
                    .opacity(opacity)
                    .onAppear { handleProgressTimer()}
                    .onDisappear { handleProgressTimer(true) }
            }
        }.frame(maxWidth: .infinity)
    }

    private var playerControls: some View {

        HStack(spacing: 50) {

            Button {
                musicPlayer.skipToPrevious()
            } label: {
                Symbols.skipBack.image
                    .imageScale(.large)
                    .font(.system(size: 30))
            }

            Button {
                musicPlayer.togglePlayBack()
                handleProgressTimer()
            } label: {
                Image(systemName: isPlaying ? Symbols.pause.name : Symbols.play.name)
                    .imageScale(.large)
                    .font(.system(size: 40))
            }.matchedGeometryEffect(id: PlayerMatchedGeometry.primaryAction.name, in: nameSpace)
                .frame(minWidth: 50, minHeight: 60)

            Button {
                musicPlayer.skipToNext()
            } label: {
                Symbols.skipForward.image
                    .imageScale(.large)
                    .font(.system(size: 30))
            }.matchedGeometryEffect(id: PlayerMatchedGeometry.secondaryAction.name, in: nameSpace)
        }
        .padding()
        .foregroundStyle(.secondary)
    }

    private var volumeSlider: some View {

        VStack {
            HStack(alignment: .top) {
                Symbols.volumeDown.image
                VolumeSliderView(tint: UIColor(.secondary))
                    .frame(maxWidth: .infinity)
                Symbols.volumeUp.image
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(.secondary)
        .padding(.top)
    }
}

#Preview {
    @Previewable @State var toggle = false
    @Previewable @Namespace var nameSpace
    GeometryReader { proxy in
        FullScreenPlayer(toggleView: $toggle, proxy: proxy, nameSpace: nameSpace)
            .environment(MusicPlayerService())
    }
}
