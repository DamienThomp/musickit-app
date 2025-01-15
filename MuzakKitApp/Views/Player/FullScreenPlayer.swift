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
    @State private var progress = 0.5

    let proxy: GeometryProxy
    let nameSpace: Namespace.ID

    private var background: Color {

        if let artworkBackground = musicPlayerManager.currentItem?.artwork?.backgroundColor {
            return Color(cgColor: artworkBackground)
        }

        return .pink
    }

    private var title: String {
        musicPlayerManager.currentItem?.title ?? ""
    }

    private var subtitle: String {
        musicPlayerManager.currentItem?.subtitle ?? ""
    }

    var body: some View {

        let width = proxy.size.width / 1.4

        ZStack {

            Rectangle()
                .fill(background.gradient)
                .matchedGeometryEffect(id: PlayerMatchedGeometry.background.name, in: nameSpace)
                .ignoresSafeArea()

            VStack {
                Capsule()
                    .frame(width: 50, height: 5)
                    .background(.thinMaterial)
                    .padding(.bottom)
                    .onTapGesture {
                        withAnimation(PlayerMatchedGeometry.animation) {
                            toggleView.toggle()
                        }
                    }

                if let artwork = musicPlayerManager.currentItem?.artwork {

                    ArtworkImage(artwork, width: width, height: width)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.coverImage.name, in: nameSpace)

                        .padding(.vertical, 40)
                        .shadow(color: .black.opacity(0.2), radius: 30, y: 15)
                        .onTapGesture {
                            withAnimation(PlayerMatchedGeometry.animation) {
                                toggleView.toggle()
                            }
                        }
                    
                } else {

                    Rectangle()
                        .fill(.secondary)
                        .frame(width: width, height: width)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.coverImage.name, in: nameSpace)
                        .padding(.vertical, 40)
                        .shadow(color: .black.opacity(0.2), radius: 30, y: 15)
                        .onTapGesture {
                            withAnimation(PlayerMatchedGeometry.animation) {
                                toggleView.toggle()
                            }
                        }
                }


                VStack {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.title.name, in: nameSpace)

                    Text(title)
                        .font(.title)
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .matchedGeometryEffect(id: PlayerMatchedGeometry.subtitle.name, in: nameSpace)

                    ProgressView(value: progress).tint(.white.opacity(0.7))

                    HStack {
                        Text("2:30").foregroundStyle(.white)
                        Spacer()
                        Text("-5:00").foregroundStyle(.white)
                    }.opacity(0.7)

                }.frame(maxWidth: .infinity)


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
                        Image(systemName: musicPlayerManager.playbackState == .playing ? "pause.fill" : "play.fill")
                            .imageScale(.large)
                            .font(.system(size: 40))
                    }.matchedGeometryEffect(id: PlayerMatchedGeometry.primaryAction.name, in: nameSpace)
                    Button {
                        musicPlayerManager.skipToNext()
                    } label: {
                        Image(systemName: "forward.fill")
                            .imageScale(.large)
                            .font(.system(size: 30))
                    }.matchedGeometryEffect(id: PlayerMatchedGeometry.secondaryAction.name, in: nameSpace)
                }
                .padding()
                .foregroundStyle(.white)

                Slider(value: $volume, in: 0...1) {
                    Text("Volume")
                } minimumValueLabel: {
                    Image(systemName: "speaker.fill")
                } maximumValueLabel: {
                    Image(systemName: "speaker.wave.3.fill")
                }
                .foregroundStyle(.white)
                .tint(.white.opacity(0.7))
                .padding(.top)

            }
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, proxy.safeAreaInsets.top)
        }
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
