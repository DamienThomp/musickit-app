//
//  AppRootView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI

struct AppRootView: View {

    @Environment(NavPath.self) private var navigation
    @Environment(MusicPlayerManager.self) private var musicPlayerManager

    @Binding var selection: AppRootScreen

    var body: some View {

        GeometryReader { proxy in
            TabView(selection: $selection) {

                ForEach(AppRootScreen.allCases, id: \.self) { screen in
                    buildTab(for: screen)
                }
            }
            .onChange(of: selection) {
                navigation.path = NavigationPath()
            }
            .tint(.pink)
            .safeAreaInset(edge: .bottom) {
                showMiniPlayer(proxy)
            }.ignoresSafeArea()
        }
    }

    @ViewBuilder
    private func buildTab(for screen: AppRootScreen) -> some View {
        screen.destination
            .tag(screen as AppRootScreen?)
            .tabItem { screen.label }
    }

    @ViewBuilder
    private func showMiniPlayer(_ proxy: GeometryProxy) -> some View {
        if musicPlayerManager.hasQueue {
            withAnimation {
                PlayerContainer(proxy: proxy)
            }
        }
    }
}

#Preview {
    AppRootView(selection: .constant(.browse))
        .environment(MusicPlayerManager())
        .environment(NavPath())
}
