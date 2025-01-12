//
//  SearchView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI
import MusicKit

struct SearchView: View {

    @Environment(NavPath.self) private var navigation

    @State var genres: MusicCatalogResourceResponse<Genre>? = nil
    @State private var searchText: String = ""

    var body: some View {
        List {
            if let genres = genres, !genres.items.isEmpty {
                VStack(alignment: .leading) {
                    Text("Browse Categories")
                        .sectionHeader()
                    LazyVGrid(
                        columns: [
                            GridItem(spacing: 12),
                            GridItem(spacing: 12)
                        ],
                        alignment: .center,
                        spacing: 12
                    ){
                        ForEach(genres.items, id: \.self) { genre in
                            genreCell(for: genre).onTapGesture {
                                navigation.path.append(genre)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText, placement: .toolbar, prompt: Text("Artists, Songs, Lyrics and More"))
        .task {
            try? await loadData()
        }.navigationTitle("Search")
    }

    @ViewBuilder
    private func genreCell(for genre: MusicItemCollection<Genre>.Element) -> some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color.random())
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 124)
            Text(genre.name)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(LinearGradient(colors: [.black.opacity(0), .black.opacity(0.5)], startPoint: .top, endPoint: .bottom))
        }
    }
}

extension SearchView {

    private func loadData() async throws {

        let charts = MusicCatalogResourceRequest<Genre>()
        let items = try await charts.response()

        updateView(with: items)
    }

    @MainActor
    private func updateView(with items: MusicCatalogResourceResponse<Genre>?) {
        Task {
            withAnimation {
                self.genres = items
            }
        }
    }
}

#Preview {
    if let genres = genreMock {
        AppRootNavigation {
            SearchView(genres: genres)
        }.environment(NavPath())
    }
}
