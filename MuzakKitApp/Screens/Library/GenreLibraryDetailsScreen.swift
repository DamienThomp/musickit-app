//
//  GenreLibraryDetailsScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-21.
//

import SwiftUI
import MusicKit

struct GenreLibraryDetailsScreen: View {

    @Environment(NavPath.self) private var navigation

    let details: MusicLibrarySection<Genre, Album>

    var body: some View {

        GeometryReader { proxy in

            let width = (proxy.size.width / 2) - 24

            ScrollView {

                VStack {

                    LazyVGrid(
                        columns: [
                            GridItem(spacing: 6),
                            GridItem(spacing: 6)
                        ],
                        alignment: .center,
                        spacing: 18
                    ) {
                        ForEach(details.items, id: \.self) { item in
                            AlbumItemCell(item: item, size: width).onTapGesture {
                                navigation.path.append(item)
                            }
                        }
                    }
                }
            }
            .contentMargins(.horizontal, 12)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(details.name)
        .navigationBarTitleDisplayMode(.large)
    }
}
