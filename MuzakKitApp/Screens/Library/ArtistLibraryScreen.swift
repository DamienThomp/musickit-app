//
//  ArtistLibraryScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-21.
//

import SwiftUI
import MusicKit

struct ArtistLibraryScreen: View {

    @Environment(NavPath.self) private var navigation

    @State private var artistSections: [MusicLibrarySection<Artist, Album>]?
    @State private var searchText: String = ""

    private var filteredItems: [MusicLibrarySection<Artist, Album>]? {

        if searchText.isEmpty {
            return artistSections
        } else {
            return artistSections?.filter {
                $0.name.lowercased().contains(
                    searchText.lowercased()
                )
            }
        }
    }

    var body: some View {

        List {
            if let filteredItems {
                ForEach(filteredItems, id: \.id) { item in
                    NavigationLink(
                        value: AppRootScreen.DetailsView.artistLibrary(item)
                    ) {
                        artistCell(item)
                    }
                    .id(item.id)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Artists")
        .navigationBarTitleDisplayMode(.large)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(
                displayMode: .always
            )
        )
        .task { loadArtists() }
    }

    @ViewBuilder
    private func artistCell(_ item: MusicLibrarySection<Artist, Album>) -> some View {

        HStack(spacing: 12) {

            artwork(item.artwork)

            Text(item.name)
                .font(.title3)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func artwork(_ artwork: Artwork?) -> some View {

        if let artwork {
            ArtworkImage(artwork, width: 40, height: 40)
                .clipShape(Circle())
        } else {
            Symbols.artistPlaceholder.image
                .resizableImage()
                .foregroundStyle(.pink.opacity(0.6))
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 40, height: 40)
        }
    }
}

extension ArtistLibraryScreen {

    private func loadArtists() {

        Task.detached {

            do {

                let request = MusicLibrarySectionedRequest<Artist, Album>()
                let response = try await request.response()
                await updateArtists(with: response)
            } catch {
                print("Couldn't load artist library items: \(error)")
            }
        }
    }

    @MainActor
    private func updateArtists(with response: MusicLibrarySectionedResponse<Artist, Album>) {
        self.artistSections = response.sections
    }
}
