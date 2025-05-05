//
//  CardMenu.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-05-04.
//

import SwiftUI
import MusicKit

struct CardMenu: View {

    @Environment(MusicPlayerService.self) private var musicPlayer
    
    let item: MusicPersonalRecommendation.Item
    
    var body: some View {
        createMenu()
    }
    
    @ViewBuilder
    private func createMenu() -> some View {
        playMusicItem(item)
    }
    
    @ViewBuilder
    private func playMusicItem(_ item: MusicPersonalRecommendation.Item) -> some View {
        
        Button {
            playMedia(item: item)
        } label: {
            Label("Play", systemImage: Symbols.play.name)
        }
    }

    private func playMedia(item: MusicPersonalRecommendation.Item) {
        
        switch item {
        case .album(let album): musicPlayer.handlePlayback(for: album)
        case .playlist(let playlist): musicPlayer.handlePlayback(for: playlist)
        default: print("Unable to play media type")
        }
    }
}
