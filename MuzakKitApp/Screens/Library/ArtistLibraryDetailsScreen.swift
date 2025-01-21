//
//  ArtistLibraryDetailsScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-21.
//

import SwiftUI
import MusicKit

struct ArtistLibraryDetailsScreen: View {

    let details: MusicLibrarySection<Artist, Album>

    var body: some View {
        GeometryReader { proxy in

            let width = (proxy.size.width / 2) - 24

            ScrollView {

                LazyVGrid(
                    columns: [
                        GridItem(spacing: 12),
                        GridItem(spacing: 12)
                    ],
                    alignment: .center,
                    spacing: 24
                ) {
                    ForEach(details.items, id: \.self) { item in
                        AlbumItemCell(item: item, size: width)
                    }
                }
            }
        }
        .navigationTitle(details.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

