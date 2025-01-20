//
//  ItemsSectionView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-29.
//

import SwiftUI
import MusicKit

struct ItemsSectionView<Content: View>: View {

    let title: String?
    let content: Content

    init(_ title: String?, @ViewBuilder _ content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            if let title {
                SectionTitle(title: title)
            }

            ScrollView(.horizontal) {
                LazyHGrid(
                    rows: [GridItem(.adaptive(minimum: 200))],
                    alignment: .top,
                    spacing: 12
                ) {
                    content
                }
                .padding(.horizontal)
            }.scrollIndicators(.hidden)
        }
        .padding([.top, .bottom], 16)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
        .background(Color(.systemGray6))
    }
}

