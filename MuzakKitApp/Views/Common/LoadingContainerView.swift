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

        Task.detached {
            do {
                let response = try await loadingAction()
                await updateView(with: response)
            } catch {
                await setErrorState(with: error)
            }
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
