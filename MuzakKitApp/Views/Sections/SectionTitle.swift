//
//  SectionTitle.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-19.
//

import SwiftUI

struct SectionTitle: View {

    let title: String

    var body: some View {
        Text(title)
            .sectionHeader()
            .lineLimit(1)
            .padding(.leading)
    }
}

#Preview {
    SectionTitle(title: "Some Title")
}
