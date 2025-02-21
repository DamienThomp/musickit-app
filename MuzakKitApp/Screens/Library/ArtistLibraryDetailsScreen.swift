//
//  ArtistLibraryDetailsScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-21.
//

import SwiftUI
import MusicKit

struct ArtistLibraryDetailsScreen: View {

    @Environment(NavPath.self) private var navigation

    let details: MusicLibrarySection<Artist, Album>

    private let size: CGFloat = 168

    private var artwork: Artwork? {
        details.artwork
    }

    private var title: String {
        details.name
    }

    var body: some View {

        GeometryReader { proxy in

            let width = (proxy.size.width / 2) - 24

            ScrollView {

                VStack {
                    headerArtwork()

                    Text(title)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)

                    LazyVGrid(
                        columns: [
                            GridItem(spacing: 12),
                            GridItem(spacing: 12)
                        ],
                        alignment: .center,
                        spacing: 24
                    ) {
                        ForEach(details.items, id: \.self) { item in
                            AlbumItemCell(item: item, size: width).onTapGesture {
                                navigation.path.append(item)
                            }
                        }
                    }
                }
            }.frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder
    private func headerArtwork() -> some View {

        if let artwork {
            ArtworkImage(artwork, width: size, height: size)
                .clipShape(Circle())
        } else {
            Symbols.artistPlaceholder.image
                    .resizableImage()
                    .padding(36)
                    .foregroundStyle(.pink.opacity(0.6))
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
                    .frame(width: size, height: size)
        }
    }
}
