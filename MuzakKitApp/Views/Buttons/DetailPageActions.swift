//
//  DetailPageActions.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-29.
//

import SwiftUI

struct DetailPageActions: View {

    let onPlay: () -> Void
    let onShuffle: () -> Void

    var body: some View {
        HStack {
            Button(action: onPlay) {
                Label("Play", systemImage: Symbols.play.name)
                    .frame(maxWidth: .infinity)
            }

            Button(action: onShuffle) {
                Label("Shuffle", systemImage: Symbols.shuffle.name)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
        .controlSize(.large)
        .padding(.horizontal, 16)
        .tint(Color(.systemGray6))
        .foregroundStyle(.pink)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    DetailPageActions(
        onPlay: { print("Play") },
        onShuffle: { print("Shuffle") }
    )
}
