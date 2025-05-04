//
//  NavigationCellView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-05-04.
//

import SwiftUI
import MusicKit

struct NavigationCellView: View {

    @Environment(\.navigationNamespace) private var navigationNamespace

    let item: MusicItem
    let size: CGFloat

    var body: some View {
        if #available(iOS 18.0, *) {
            cellBuilder().matchedTransitionSource(id: item.id, in: navigationNamespace!)
        } else {
            cellBuilder()
        }
    }

    @ViewBuilder
    private func cellBuilder() -> some View {
        if let item = item as? Album {
            AlbumItemCell(item: item, size: size)
        }

        if let item = item as? Playlist {
            PlaylistItemCell(item: item, size: size)
        }

        if let item = item as? Artist {
            ArtistItemCell(item: item, size: size)
        }
    }
}
