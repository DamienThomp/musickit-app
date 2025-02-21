//
//  GenreItemCell.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-20.
//

import SwiftUI
import MusicKit

struct GenreItemCell: View {

    let genre: MusicItemCollection<Genre>.Element

    var body: some View {

        ZStack(alignment: .bottomLeading) {
            
            Rectangle()
                .fill(Color.randomColor)
                .frame(height: 120)

            Text(genre.name)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
                .background(
                    LinearGradient(
                        colors: [
                            .black.opacity(0),
                            .black.opacity(0.5)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )            
        }.artworkCornerRadius(.large)
    }
}
