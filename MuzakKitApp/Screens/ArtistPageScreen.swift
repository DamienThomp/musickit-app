//
//  ArtistPageScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-01.
//

import SwiftUI
import MusicKit

struct ArtistPageScreen: View {

    let artist: Artist

    @State private var albums: MusicItemCollection<Album>?
    @State private var appearsOn: MusicItemCollection<Album>?
    @State private var similarArtists: MusicItemCollection<Artist>?

    private var artwork: Artwork? {
        artist.artwork
    }

    private var title: String {
        artist.name
    }

    var body: some View {
        List {
            header
                .listStyle(.plain)
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .padding(.bottom, 24)

            if let albums = albums, !albums.isEmpty {

                ItemsSectionView("Albums by \(artist.name)") {
                    ForEach(albums, id: \.self) { album in
                        NavigationLink(value: album) {
                            AlbumItemCell(item: album, size: 160)
                        }.tint(.primary)
                    }
                }
            }

            if let appearsOn = appearsOn, !appearsOn.isEmpty {
                ItemsSectionView(appearsOn.title) {
                    ForEach(appearsOn, id: \.self) { album in
                        NavigationLink(value: album) {
                            AlbumItemCell(item: album, size: 160)
                        }.tint(.primary)
                    }
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            loadSections()
        }
    }

    private var header: some View {

        VStack(alignment: .center, spacing: 2) {

            if let artwork {
                ArtworkImage(
                    artwork,
                    width: 240,
                    height: 240
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 14)
            }

            Text(title)
                .font(.system(.largeTitle))
                .foregroundStyle(.pink)
                .multilineTextAlignment(.center)
        }
        .lineLimit(2)
    }

    private func loadSections() {
        Task {
            do {
                let artistDetails = try await artist.with([.albums, .appearsOnAlbums, .similarArtists])
                updateSections(with: artistDetails)
            } catch {
                print("can't load data: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    private func updateSections(with artist: Artist) {
        withAnimation {
            self.albums = artist.albums
            self.appearsOn = artist.appearsOnAlbums
            self.similarArtists = artist.similarArtists
        }
    }
}
