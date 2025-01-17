//
//  FullScreenPlayer.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-15.
//

import SwiftUI
import MusicKit

struct FullScreenPlayer: View {

    @Environment(MusicPlayerManager.self) private var musicPlayerManager

    @Binding var toggleView: Bool

    @State private var volume = 0.5
    @State private var playerOffset = 0.0

    let proxy: GeometryProxy
    let nameSpace: Namespace.ID

    private let opacity: CGFloat = 0.85

    private var isPlaying: Bool {
        musicPlayerManager.playbackState == .playing
    }

    private var artwork: Artwork? {
        musicPlayerManager.artwork
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

    private var primarytextColor: Color {
        .primary
    }

    private var secondaryTextColor: Color {
        .secondary
    }

    private var title: String {
        musicPlayerManager.currentItem?.title ?? ""
    }

    private var subtitle: String {
        musicPlayerManager.currentItem?.subtitle ?? ""
    }

    private var duration: Double? {

        guard let item = musicPlayerManager.currentItem?.item else {
            return nil
        }

        switch item {
        case .song(let song):
            return song.duration
        case .musicVideo(let musicVideo):
            return musicVideo.duration
        @unknown default:
            return nil
        }
    }

    var body: some View {

        let width = proxy.size.width - 48

        ZStack {

            Rectangle()
                .fill(hasBackground ? background.gradient : defaultBackground.gradient)
                .clipShape(RoundedRectangle(cornerRadius: proxy.safeAreaInsets.top))
                .animation(.easeIn, value: hasBackground)
                .colorMultiply(Color(hue: 0.0, saturation: 0, brightness: 0.7))
                .matchedGeometryEffect(id: PlayerMatchedGeometry.background.name, in: nameSpace)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            VStack {
                Capsule()
                    .fill(secondaryTextColor.opacity(opacity))
                    .frame(width: 50, height: 5)
                    .padding(.bottom)
                    .onTapGesture {
                        withAnimation(PlayerMatchedGeometry.animation) {
                            toggleView.toggle()
                        }
                    }

                if let artwork = artwork {

                    ArtworkImage(artwork, width: width, height: width)
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.coverImage.name, in: nameSpace)
                        .frame(width: width, height: width)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.top, 14)
                        .padding(.bottom, 32)
                        .shadow(color: .black.opacity(0.2), radius: 30, y: 15)
                        .scaleEffect(isPlaying ? 1 : 0.8)
                        .animation(.interpolatingSpring(duration: 0.5, bounce: 0.5), value: isPlaying)

                } else {

                    Rectangle()
                        .fill(.secondary)
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.coverImage.name, in: nameSpace)
                        .frame(width: width, height: width)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.top, 14)
                        .padding(.bottom, 32)
                        .shadow(color: .black.opacity(0.2), radius: 30, y: 15)
                }

                VStack {
                    VStack {
                        Text(title)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(primarytextColor)
                            .lineLimit(1)
                            .matchedGeometryEffect(id: PlayerMatchedGeometry.title.name, in: nameSpace)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(subtitle)
                            .font(.title3)
                            .foregroundStyle(secondaryTextColor.opacity(opacity))
                            .lineLimit(1)
                            .matchedGeometryEffect(id: PlayerMatchedGeometry.subtitle.name, in: nameSpace)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 20)

                        if let duration = duration {
                            PlayerProgressView(duration: duration)
                                .tint(secondaryTextColor)
                                .foregroundStyle(secondaryTextColor)
                                .opacity(opacity)
                        }

                    }.frame(maxWidth: .infinity)

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
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    let translationY = gesture.translation.height
                    withAnimation {
                        playerOffset = (translationY > 0 ? translationY : 0)
                    }
                }.onEnded { value in
                    let velocity = CGSize(
                        width:  value.predictedEndLocation.x - value.location.x,
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
        )
    }

    var playerControls: some View {

        HStack(spacing: 50) {
            Button {
                musicPlayerManager.skipToPrevious()
            } label: {
                Image(systemName: "backward.fill")
                    .imageScale(.large)
                    .font(.system(size: 30))
            }
            Button {
                musicPlayerManager.togglePlayBack()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .imageScale(.large)
                    .font(.system(size: 40))

            }.matchedGeometryEffect(id: PlayerMatchedGeometry.primaryAction.name, in: nameSpace)
                .frame(minWidth: 50, minHeight: 60)
            Button {
                musicPlayerManager.skipToNext()
            } label: {
                Image(systemName: "forward.fill")
                    .imageScale(.large)
                    .font(.system(size: 30))
            }.matchedGeometryEffect(id: PlayerMatchedGeometry.secondaryAction.name, in: nameSpace)
        }
        .padding()
        .foregroundStyle(primarytextColor)

    }

    var volumeSlider: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "speaker.fill")
                VolumeSliderView(tint: UIColor(secondaryTextColor))
                    .frame(maxWidth: .infinity)
                Image(systemName: "speaker.wave.3.fill")
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(secondaryTextColor)
        .padding(.top)
    }
}

#Preview {
    @Previewable @State var toggle = false
    @Previewable @Namespace var nameSpace
    GeometryReader { proxy in
        FullScreenPlayer(toggleView: $toggle, proxy: proxy, nameSpace: nameSpace)
            .environment(MusicPlayerManager())
    }
}

// TODO: - refactor player progress view
struct PlayerProgressView: View {

    @Environment(MusicPlayerManager.self) var musicPlayerManager

    let duration: TimeInterval

    private var progress: TimeInterval {

        if let progress = musicPlayerManager.currentPlayBackTime {
            return progress
        }

        return 0.0
    }

    private var remaining: TimeInterval {

        return -(duration) + progress
    }

    var body: some View {

        ProgressView(value: progress, total: duration)

        HStack {
            Text(progress, format: .timerCountdown)
                .font(.caption)

            Spacer()
            Text(remaining, format: .timerCountdown)
                .font(.caption)

        }
    }
}
