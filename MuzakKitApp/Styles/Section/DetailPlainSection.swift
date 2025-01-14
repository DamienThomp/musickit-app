//
//  DetailPlainSection.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-08.
//

import SwiftUI

struct DetailPlainSection: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .listRowBackground(Color(.systemBackground))
            .listRowSeparator(.hidden)
    }
}
