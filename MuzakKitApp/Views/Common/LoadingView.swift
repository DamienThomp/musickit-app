//
//  LoadingView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-02-27.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {

        ContentUnavailableView {
            VStack(spacing: 12) {
                ProgressView()
                Text("Loading ...")
            }
        }
    }
}
