//
//  PlaylistForm.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-24.
//

import SwiftUI
import MusicKit

struct PlaylistForm: View {

    @Environment(MusicKitService.self) private var musicKitService
    @Environment(\.dismiss) private var dismiss

    @State private var playlists: MusicItemCollection<Playlist>?
    @State private var errorMessage: String = ""
    @State private var presentError: Bool = false
    @State private var showLoadingView: Bool = false

    private var recentPlaylists: [Playlist]? {

        guard let playlists else { return nil }

        let recentItems = playlists[0..<4]

        guard !recentItems.isEmpty else {
            return nil
        }

        return Array(recentItems)
    }

    var body: some View {

        NavigationStack {

            List {

                if let recentPlaylists {

                    Section("Recent Playlists") {
                        ForEach(recentPlaylists, id: \.self) { item in
                            playlistItem(item)
                                .onTapGesture {
                                    addToPlaylist(with: item)
                                }
                        }.listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    }
                }

                if let playlists {

                    Section("All Playlists") {
                        ForEach(playlists, id: \.self) { item in
                            playlistItem(item)
                                .onTapGesture {
                                    addToPlaylist(with: item)
                                }
                        }.listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Add to a Playlist")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }.tint(.pink)
                }
            }.overlay(alignment: .center) {
                if showLoadingView {
                    ZStack {
                        Color(.systemGray6)
                            .opacity(0.8)
                            .ignoresSafeArea()
                        ProgressView()
                    }
                }
            }
        }
        .task(loadPlaylists)
        .alert(errorMessage, isPresented: $presentError) {
            Button {
                presentError = false
            } label: {
                Text("Ok")
            }
        }
    }

    @ViewBuilder
    private func playlistItem(_ item: Playlist) -> some View {

        HStack {

            playlistArtwork(item.artwork)
            Text(item.name)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .padding(.horizontal)
    }

    @ViewBuilder
    private func playlistArtwork(_ artwork: Artwork?) -> some View {

        if let artwork {

            ArtworkImage(artwork, width: 50)
                .artworkCornerRadius(.medium)
        } else {

            Rectangle()
                .fill(Color(.systemBackground))
                .frame(width: 50, height: 50)
                .artworkCornerRadius(.medium)
        }
    }
}

extension PlaylistForm {

    private func addToPlaylist(with selected: Playlist) {

        guard let item = musicKitService.itemToAdd else { return }

        Task {
            showLoadingView = true
            do {
                let library = MusicLibrary.shared
                try await library.add(item, to: selected)
                showLoadingView = false
                dismiss()
            } catch {
                handleError(with: "Can't add item to Playlist: \(error)")
            }
        }
    }

    @Sendable
    private func loadPlaylists() async {

        do {

            var request = MusicLibraryRequest<Playlist>()
            request.sort(by: \.libraryAddedDate, ascending: false)
            request.includeOnlyDownloadedContent = true

            let response = try await request.response()

            updateView(with: response)
        } catch {
            print("Can't load playlists with: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func handleError(with error: String) {
        self.errorMessage = error
        self.presentError = true
    }

    @MainActor
    private func updateView(with response: MusicLibraryResponse<Playlist>) {
        self.playlists = response.items
    }
}

#Preview {
    let musicKitService = MusicKitServiceFactory.create()

    NavigationStack {
        PlaylistForm()
            .environment(musicKitService)
    }.tint(.pink)
}
