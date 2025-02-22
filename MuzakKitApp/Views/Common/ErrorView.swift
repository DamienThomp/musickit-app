//
//  ErrorView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-02-22.
//

import SwiftUI

struct ErrorView: View {

    var message: String?
    var action: (() -> Void)?

    var body: some View {
        ContentUnavailableView {
            VStack {
                Image(.launchIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }
        } description: {
            if let message {
                Text(message)
            }
        } actions: {
            if let action {
                Button {
                    action()
                } label: {
                    Text("Retry")
                }
                .foregroundStyle(.pink)
                .buttonStyle(.bordered)
            }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ErrorView(message: "something went wrong", action: { print("retry") })
}
