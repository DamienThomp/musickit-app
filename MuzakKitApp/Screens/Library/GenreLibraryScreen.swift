//
//  GenreLibraryScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-21.
//

import SwiftUI
import MusicKit

struct GenreLibraryScreen: View {

    @State private var genres: [MusicLibrarySection<Genre, Album>]?

    @State private var searchText: String = ""

    private var results: [MusicLibrarySection<Genre, Album>]? {

        if searchText.isEmpty {
            return genres
        } else {
            return genres?.filter { $0.name.lowercased().contains(searchText.lowercased())}
        }
    }

    var body: some View {

        List {
            if let results, !results.isEmpty {
                ForEach(results, id: \.self) { item in
                    genreListCell(item)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Genres")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .task { await loadData() }
    }

    @ViewBuilder
    private func genreListCell(_ item: MusicLibrarySection<Genre, Album>) -> some View {

        NavigationLink(
            value: AppRootScreen.DetailsView.genreLibrary(item)
        ) {
            Text(item.name)
                .font(.title3)
                .foregroundStyle(.pink)
        }
    }
}

extension GenreLibraryScreen {

    private func loadData() async {

        do {
            let request = MusicLibrarySectionedRequest<Genre, Album>()
            let response = try await request.response()

            updateData(with: response)
        } catch {
            print("Can't load genre data: \(error.localizedDescription)")
        }
    }

    @MainActor
    private func updateData(with response: MusicLibrarySectionedResponse<Genre, Album>) {
        self.genres = response.sections
    }
}
