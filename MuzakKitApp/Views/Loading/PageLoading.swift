//
//  PageLoading.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-19.
//

import SwiftUI

struct PageLoading: View {
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                ProgressView()
                Text("Loading ...")
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PageLoading()
}
