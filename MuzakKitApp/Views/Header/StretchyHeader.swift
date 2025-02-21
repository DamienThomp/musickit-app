//
//  StretchyHeader.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-19.
//

import SwiftUI

struct StretchyHeader<Content: View, Space: Hashable>: View {

    let coordinateSpace: Space
    let defaultHeight: CGFloat

    @ViewBuilder let content: Content

    var body: some View {

        GeometryReader { proxy in

            let offset = offset(for: proxy)
            let heightModifier = heightModifier(for: proxy)

            content
                .ignoresSafeArea(.container, edges: .all)
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height + heightModifier
                )
                .offset(y: offset)
        }.frame(height: defaultHeight)
    }

    private func offset(for proxy: GeometryProxy) -> CGFloat {

        let frame = proxy.frame(in: .named(coordinateSpace))

        if frame.minY < 0 {
            return -frame.minY * 0.8
        }
        return -frame.minY
    }

    private func heightModifier(for proxy: GeometryProxy) -> CGFloat {

        let frame = proxy.frame(in: .named(coordinateSpace))
        return max(0, frame.minY)
    }
}
