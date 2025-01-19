//
//  DetailPageActions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-29.
//

import SwiftUI

struct DetailPageActions: View {

    let handlePlayback: () -> Void
    let handleShuffle: () -> Void

    init(_ handlePlayback: @escaping () -> Void, _ handleShuffle: @escaping () -> Void) {
        self.handlePlayback = handlePlayback
        self.handleShuffle = handleShuffle
    }

    var body: some View {
        HStack {
            Button {
                handlePlayback()
            } label: {
                HStack {
                    Symbols.play.image
                    Text("Play")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)

            Button {
                handleShuffle()
            } label: {
                HStack {
                    Symbols.shuffle.image
                    Text("Shuffle")
                }.frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .controlSize(.large)
        .padding(.horizontal, 16)
        .tint(Color(.systemGray6))
        .foregroundStyle(.pink)
    }
}

#Preview {
    DetailPageActions {
        print("Primary")
    } _: {
        print("Secondary")
    }
}
