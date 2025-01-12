//
//  AppRootView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import SwiftUI

struct AppRootView: View {
    
    @Binding var selection: AppRootScreen

    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppRootScreen.allCases, id: \.self) { screen in
                buildTab(for: screen)
            }
        }.tint(.pink)
    }

    @available(iOS 18.0, *)
    private func buildTab(for screen: AppRootScreen) -> any TabContent {
        Tab {
            screen.destination
        } label: {
            screen.label
        }
    }

    @ViewBuilder
    private func buildTab(for screen: AppRootScreen) -> some View {
        screen.destination
            .tag(screen as AppRootScreen?)
            .tabItem { screen.label }
    }
}

#Preview {
    AppRootView(selection: .constant(.browse))
        .environment(MusicPlayerManager())
}
