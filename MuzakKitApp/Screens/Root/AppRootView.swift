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

    private var hasSeenAuthMessage: Bool {
        let authStatus = musicKitService.authStatus
        return authStatus != .notDetermined
    }

    var body: some View {

        @Bindable var musicKitService = musicKitService

        if showDefaultScreen {
            unAuthorizedView
        } else {
            GeometryReader { proxy in
                TabView(selection: $selection) {

                    ForEach(AppRootScreen.allCases, id: \.self) { screen in
                        buildTab(for: screen)
                    }
                }
                .onChange(of: selection) { navigation.path = NavigationPath() }
                .tint(.pink)
                .scrollIndicators(.hidden)
                .safeAreaInset(edge: .bottom) { showMiniPlayer(proxy) }
                .ignoresSafeArea(.container, edges: .top)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .sheet(isPresented: $musicKitService.presentPlaylistform) { PlaylistForm() }
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
            PlayerContainer(proxy: proxy)
        }
    }

    @ViewBuilder
    private var unAuthorizedView: some View {
        ContentUnavailableView {
            VStack {
                Image(.launchIcon)
                    .resizableImage()
            }.frame(width: 250, height: 250)
        } description: {
            if hasSeenAuthMessage {
                Text("This app needs permission to view your Apple Music Library. Authorize to continue.")
            }
        } actions: {
            if hasSeenAuthMessage {
                HStack {
                    handleAuthButton
                }
            }
        }.preferredColorScheme(.dark)
    }

    @ViewBuilder
    private var handleAuthButton: some View {
        Button {
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                openURL(settingsURL)
            }
        } label: {
            Label("Authorize", systemImage: Symbols.checkMarkCircle.name)
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
