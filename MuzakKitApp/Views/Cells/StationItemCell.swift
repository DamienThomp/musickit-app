//
//  StationItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-07.
//

import SwiftUI
import MusicKit

struct StationItemCell: View {

    let item: Station
    let size: CGFloat

    var body: some View {

        VStack(alignment: .leading) {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: size)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Text(item.name)
                .font(.system(.subheadline))
                .lineLimit(1)

        }.frame(maxWidth: size)
    }
}
