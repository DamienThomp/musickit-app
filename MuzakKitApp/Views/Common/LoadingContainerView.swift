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

        VStack {

            switch loadingState {
            case .idle:
                EmptyView()
            case .loading:
                LoadingView()
            case .success(let response):
                content(response)
            case .error(let error):
                ErrorView(message: error.localizedDescription) {
                    Task {
                        retryLoading()
                        await fetchData()
                    }
                }
            }
        }.task(fetchData)
    }

    @Sendable
    private func fetchData() async {

        do {
            let response = try await loadingAction()
            updateView(with: response)
        } catch {
            setErrorState(with: error)
        }
    }

    @MainActor
    private func retryLoading() {
        
        withAnimation {
            loadingState = .loading
        }
    }

    @MainActor
    private func setErrorState(with error: Error) {

        withAnimation {
            loadingState = .error(error)
        }
    }

    @MainActor
    private func updateView(with data: T) {

        withAnimation {
            loadingState = .success(data)
        }
    }
}
