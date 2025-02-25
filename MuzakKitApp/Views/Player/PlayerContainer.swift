//
//  SwiftUIView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-15.
//

import SwiftUI

struct PlayerContainer: View {

    @Namespace private var playerNamespace

    @State private var showFullscreenView = false

    let proxy: GeometryProxy

    var body: some View {

        if !showFullscreenView {

            MiniMusicPlayer(
                toggleView: $showFullscreenView,
                nameSpace: playerNamespace
            )
            .padding()
            .offset(y: -proxy.safeAreaInsets.bottom)
        } else {

            FullScreenPlayer(
                toggleView: $showFullscreenView,
                proxy: proxy,
                nameSpace: playerNamespace
            )
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    GeometryReader { proxy in
        PlayerContainer(proxy: proxy)
    }
}
