//
//  HeaderTitle.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-02-12.
//

import SwiftUI

struct HeaderTitle: View {

    let text: String
    let action: (_ value: CGFloat) -> Void

    private func calculatePosition(_ proxy: GeometryProxy) -> CGFloat {
        return proxy.frame(in: .global).origin.y - proxy.safeAreaInsets.top - proxy.size.height
    }

    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }

    var body: some View {
        Text(text)
            .background(
                 GeometryReader { proxy in
                     let value = calculatePosition(proxy)
                     Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: value)
                 }
            )
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                withAnimation {
                    action(value)
                }
            }
    }
}

#Preview {
    HeaderTitle(text: "Some Text", action: { _ in })
}
