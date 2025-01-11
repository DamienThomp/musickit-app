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

    @State private var artistDetails: Artist?
    @State private var isLoading: Bool = true

    private var artwork: Artwork? {
        artist.artwork
    }

    private var title: String {
        artist.name
    }

    var body: some View {

        List {
            header
                .plainHeaderStyle()
                .frame(maxWidth: .infinity)

            if let albums = artistDetails?.albums, !albums.isEmpty {

                ItemsSectionView("Albums by \(artist.name)") {
                    ForEach(albums, id: \.self) { album in
                        NavigationLink(value: album) {
                            AlbumItemCell(item: album, size: 160)
                        }.tint(.primary)
                    }
                }
            }

            if let singles = artistDetails?.singles, !singles.isEmpty {

                ItemsSectionView(singles.title) {
                    ForEach(singles, id: \.self) { album in
                        NavigationLink(value: album) {
                            AlbumItemCell(item: album, size: 160)
                        }.tint(.primary)
                    }
                }
            }


            if let appearsOn = artistDetails?.appearsOnAlbums, !appearsOn.isEmpty {

                ItemsSectionView(appearsOn.title) {
                    ForEach(appearsOn, id: \.self) { album in
                        NavigationLink(value: album) {
                            AlbumItemCell(item: album, size: 160)
                        }.tint(.primary)
                    }
                }
            }

            if let featured = artistDetails?.featuredAlbums, !featured.isEmpty {

                ItemsSectionView(featured.title) {
                    ForEach(featured, id: \.self) { album in
                        NavigationLink(value: album) {
                            AlbumItemCell(item: album, size: 160)
                        }.tint(.primary)
                    }
                }
            }

            if let playlists = artistDetails?.playlists, !playlists.isEmpty {

                ItemsSectionView("Playlists") {
                    ForEach(playlists, id: \.self) { item in
                        NavigationLink(value: item) {
                            PlaylistItemCell(item: item, size: 160)
                        }.tint(.primary)
                    }
                }
            }

            if let similarArtists = artistDetails?.similarArtists, !similarArtists.isEmpty {

                ItemsSectionView(similarArtists.title) {
                    ForEach(similarArtists, id: \.self) { item in
                        NavigationLink(value: item) {
                            ArtistItemCell(item: item, size: 160)
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


}

extension ArtistPageScreen {

    private func loadSections() {

        Task {
            do {

                let artistDetails = try await artist.with(
                    [
                        .albums,
                        .singles,
                        .appearsOnAlbums,
                        .similarArtists,
                        .featuredAlbums,
                        .playlists
                    ]
                )
                updateSections(with: artistDetails)
            } catch {
                print("can't load data: \(error.localizedDescription)")
            }
        }
    }

    @MainActor
    private func updateSections(with artist: Artist) {
        withAnimation {
            
            self.isLoading = false
            self.artistDetails = artist
        }
    }
}
