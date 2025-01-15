//
//  TopResultCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-13.
//

import SwiftUI
import MusicKit

struct TopResultCell: View {

    let title: String
    let subtitle: String?
    let artwork: Artwork?
    let size: CGFloat

    var body: some View {
        VStack(alignment: .leading) {

            Text(title)
                .lineLimit(1)
                .font(.title2)
                .frame(maxWidth: size, alignment: .leading)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: size, alignment: .leading)
            }

            if let artwork = artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .cornerRadius(12)
            } else {
                Rectangle()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
