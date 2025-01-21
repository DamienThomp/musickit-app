//
//  HorizontalGrid.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-17.
//

import SwiftUI

struct HorizontalGrid<Content: View>: View {

    let grid: CGFloat
    let rows: Int
    let gutterSize: CGFloat
    var viewAligned: Bool = true
    var alignment: VerticalAlignment = .top
    let width: CGFloat

    private var contentWidth: CGFloat {
        width / grid
    }

    private var gridRows: [GridItem] {
        Array(repeating: .init(.flexible(minimum: 50)), count: rows)
    }

    @ViewBuilder let content: (_ width: CGFloat) -> Content

    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                LazyHGrid(
                    rows: gridRows,
                    alignment: alignment,
                    spacing: gutterSize
                ) {
                    content(contentWidth)
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .safeAreaPadding(.horizontal)
            .scrollTargetBehavior(
                viewAligned ? .viewAligned : .viewAligned(
                    limitBehavior: .never
                )
            )
        }
    }
}

