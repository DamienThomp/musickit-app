//
//  AppRootView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI

struct AppRootView: View {

    @Environment(NavPath.self) private var navigation
    @Environment(MusicPlayerService.self) private var musicPlayer
    @Environment(MusicKitService.self) private var musicKitService

    @Environment(\.openURL) private var openURL

    @Binding var selection: AppRootScreen

    private var showDefaultScreen: Bool {

        let authStatus = musicKitService.authStatus
        return authStatus != .authorized 
    }

    var body: some View {

        if showDefaultScreen {
            unAuthorizedView
        } else {
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
                }.ignoresSafeArea(.container, edges: .top)
            }
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
        if musicPlayer.hasQueue {
            withAnimation {
                PlayerContainer(proxy: proxy)
            }
        }
    }

    @ViewBuilder
    private var unAuthorizedView: some View {
        ContentUnavailableView {
            VStack {
                Symbols.warning.image
                    .foregroundStyle(.orange)
                Text("Unauthorized").font(.title3)
            }.foregroundStyle(.primary)
        } description: {
            Text("Users must accept Authorization to use this App.")
        } actions: {
            HStack {
                handleAuthButton
            }
        }
    }

    @ViewBuilder
    private var handleAuthButton: some View {
        Button {
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                openURL(settingsURL)
            }
        } label: {
            Label("Authorize", systemImage: "checkmark.circle")
        }
        .foregroundStyle(.pink)
        .buttonStyle(.bordered)
    }
}

#Preview {
    AppRootView(selection: .constant(.browse))
        .environment(MusicKitService())
        .environment(MusicPlayerService())
        .environment(NavPath())
}
