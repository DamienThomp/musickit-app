//
//  LoadingContainerView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-02-23.
//

import SwiftUI

enum LoadingState<T: Codable> {

    case idle
    case loading
    case success(T)
    case error(Error)
}

struct LoadingContainerView<T: Codable, Content: View>: View {

    let loadingAction: () async throws -> T

    @ViewBuilder let content: (T) -> Content

    @State private var loadingState: LoadingState<T> = .loading

    var body: some View {
        VStack(alignment: .center) {

            switch loadingState {
            case .idle:
                EmptyView()
            case .loading:
                LoadingView()
               // ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
            case .success(let response):
                content(response)
            case .error(let error):
                ErrorView(message: error.localizedDescription) {
                    fetchData()
                }
            }
        }.task { fetchData() }
    }

    private func fetchData() {

        Task {
            do {
                let response = try await loadingAction()
                updateView(with: response)
            } catch {
                loadingState = .error(error)
            }
        }
    }

    @MainActor
    private func updateView(with data: T) {
        withAnimation {
            loadingState = .success(data)
        }
    }
}
