//
//  PlaylistDetailScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-24.
//

import SwiftUI
import MusicKit

struct PlaylistDetailScreen: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.haptics) private var haptics

    @Environment(MusicPlayerService.self) private var musicPlayer
    @Environment(MusicKitService.self) private var musicService

    let playlist: Playlist

    @State private var tracks: MusicItemCollection<Track>?
    @State private var featuredArtists: MusicItemCollection<Artist>?

    @State private var isInLibrary: Bool = false

    private var artwork: Artwork? {
        playlist.artwork
    }

    private var name: String {
        playlist.name
    }

    private var curatorName: String? {
        playlist.curatorName
    }

    private var count: Int? {
        tracks?.count
    }

    private var duration: TimeInterval {

        let total = tracks?.reduce(0.0, { partialResult, track in
            guard let duration = track.duration else { return 0.0 }
            return partialResult + duration
        })

        return total ?? 0.0
    }

    var body: some View {

        List {

            header
                .plainHeaderStyle()
                .frame(maxWidth: .infinity)

            actions
                .plainHeaderStyle()
                .padding(.bottom)

            if let tracks = tracks, !tracks.isEmpty {
                Section {
                    ForEach(tracks.indices, id: \.self) { index in
                        PlaylistTrackCell(track: tracks[index]) {
                            MenuItems(item: tracks[index], tracks: tracks, isInLibrary: $isInLibrary)
                        }
                        .onTapGesture {
                            musicPlayer
                                .handleItemSelected(
                                    for: tracks[index],
                                    from: tracks
                                )
                        }.contextMenu {
                            MenuItems(item: tracks[index], tracks: tracks, isInLibrary: $isInLibrary)
                        }
                    }
                } footer: {
                    HStack {
                        if let count = count {
                            Text("\(count) songs,")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(duration, format: .duration(style: .full))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }.padding(.vertical)
                }
            }

            if let artists = featuredArtists, !artists.isEmpty {

                ItemsSectionView(artists.title ?? "Featured Artists") {
                    ForEach(artists, id: \.self) { artist in
                        NavigationLink(value: artist) {
                            ArtistItemCell(item: artist, size: 160)
                        }.tint(.primary)
                    }
                }
            }
        }
        .background(Color(.systemGray6), ignoresSafeAreaEdges: .bottom)
        .tint(.pink)
        .listStyle(.plain)
        .navigationBarBackButtonHidden(true)
        .toolbar {

            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Symbols.chevronBack.image
                        .padding([.trailing, .vertical])
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    addToLibrary()
                } label: {
                    Image(systemName: isInLibrary ? Symbols.checkmarkCircle.name : Symbols.plusCircle.name)
                        .contentTransition(.symbolEffect(.replace))
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    MenuItems(item: playlist, isInLibrary: $isInLibrary)
                } label: {
                    Symbols.ellipsis.image
                }.contentShape(Rectangle())
            }
        }
        .task { await loadTracks() }
    }

    private var header: some View {

        VStack(alignment: .center) {

            if let artwork {
                ArtworkImage(
                    artwork,
                    width: 240,
                    height: 240
                )
                .artworkCornerRadius(.large)
                .padding(.bottom)
            }

            Text(name)
                .font(.system(.title2))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)

            if let curatorName {
                Text(curatorName)
                    .font(.system(.title2))
                    .foregroundStyle(.pink)
            }
        }
    }

    private var actions: some View {

        DetailPageActions {
            musicPlayer.handlePlayback(for: playlist)
        } _: {
            musicPlayer.shufflePlayback(for: playlist)
        }
    }
}

extension PlaylistDetailScreen {

    private func addToLibrary() {

        guard !isInLibrary else { return }

        Task { @MainActor in
            do {
                try await musicService.addToLibrary(playlist)
                self.isInLibrary = true
                haptics.impact(.light)
            } catch {
                print("can't add to library: \(error.localizedDescription)")
            }
        }
    }

    private func loadTracks() async {

        do {
            let playlist = try await musicService.getData(
                for: playlist,
                with: [
                    .tracks,
                    .featuredArtists
                ]
            )
            update(tracks: playlist.tracks, artists: playlist.featuredArtists)
        } catch {
            print("failed to load tracks for playlist with: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func update(tracks: MusicItemCollection<Track>?, artists: MusicItemCollection<Artist>?) {
        withAnimation {
            self.tracks = tracks
            self.featuredArtists = artists
        }
    }
}
