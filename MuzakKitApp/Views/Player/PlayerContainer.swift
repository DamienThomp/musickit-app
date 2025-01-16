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
            MiniMusicPlayer(toggleView: $showFullscreenView, nameSpace: playerNamespace)
                .offset(y: -proxy.safeAreaInsets.top)
        } else {
            FullScreenPlayer(toggleView: $showFullscreenView, proxy: proxy, nameSpace: playerNamespace)
        }
    }
}

#Preview {
    GeometryReader { proxy in
        PlayerContainer(proxy: proxy)
    }
}
