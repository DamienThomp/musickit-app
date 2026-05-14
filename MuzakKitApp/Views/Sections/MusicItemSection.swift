//
//  MusicItemSection.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2026-05-14.
//

import SwiftUI
import MusicKit

struct MusicItemSection<T: MusicItem & Hashable>: View {

    let collection: MusicItemCollection<T>
    let fallbackTitle: String
    let width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {

            SectionTitle(title: collection.title ?? fallbackTitle)

            HorizontalGrid(
                grid: 2.4,
                rows: 1,
                gutterSize: 12,
                viewAligned: false,
                width: width
            ) { width in
                ForEach(collection, id: \.self) { item in
                    NavigationLink(value: item) {
                        NavigationCellView(item: item, size: width)
                    }.tint(.primary)
                }
            }
        }
    }
}
