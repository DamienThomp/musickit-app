//
//  BrowseView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-22.
//

import SwiftUI
import MusicKit

struct BrowseView: View {

    @Environment(MusicPlayerManager.self) private var musicPlayer

    @State var recommendations: MusicItemCollection<MusicPersonalRecommendation>?

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 30) {

                if let recommendations = recommendations {

                    ForEach(recommendations, id: \.self) { recommendation in

                        VStack(alignment: .leading) {

                            if let title = recommendation.title {
                                Text(title)
                                    .sectionHeader()
                                    .padding(.leading)
                            }

                            if let reason = recommendation.reason {
                                Text(reason)
                                    .sectionSubtitle()
                                    .padding(.leading)
                            }

                            if !recommendation.items.isEmpty {
                                let items = recommendation.items
                                
                                ScrollView(.horizontal, showsIndicators: false) {

                                    LazyHGrid(
                                        rows: [GridItem(
                                            .adaptive(
                                                minimum: 250,
                                                maximum: 250
                                            )
                                        )],
                                        alignment: .top,
                                        spacing: 12
                                    ) {
                                        ForEach(items, id: \.self) { item in
                                            
                                            renderCard(for: item)
                                                .tint(.primary)
                                        }
                                    }
                                    .padding(.leading)
                                    .scrollTargetLayout()
                                }
                            }
                        }
                    }
                }
            }
            .task {
                await fetchLibrary()
            }
        }.navigationTitle("Browse")
    }

    @ViewBuilder
    private func renderCard(for item: MusicPersonalRecommendation.Item) -> some View {

        switch item.self {
        case .album(let album):

            NavigationLink(value: album) {
                AlbumItemCell(item: album, size: 168)
            }
        case .playlist(let playlist):

            NavigationLink(value: playlist) {
                PlaylistItemCell(item: playlist, size: 168)
            }
        case .station(let station):

            StationItemCell(item: station, size: 168)
                .onTapGesture {
                    playStation(station)
                }
        @unknown default:
            Text("Unknown View")
        }
    }
}

extension BrowseView {

    private func playStation(_ station: Station) {
        musicPlayer.handlePlayback(for: station)
    }

    private func getMusic() {

        Task { @MainActor in
            do {
                let recommendationsRequest = MusicPersonalRecommendationsRequest()
                let recommendations = try await recommendationsRequest.response()
                self.recommendations = recommendations.recommendations
            } catch {
                print(error)
            }
        }
    }

    private func fetchLibrary() async {

        let status = await MusicAuthorization.request()
        switch status {

        case .notDetermined:
            // do nothing for now
            print(status.rawValue)
        case .denied:
            // do nothing for now
            print(status.rawValue)
        case .restricted:
            // do nothing for now
            print(status.rawValue)
        case .authorized:
            getMusic()
        @unknown default:
            // do nothing
            print(status.rawValue)
            return
        }
    }
}

#Preview {
    AppRootNavigation {
        BrowseView()
            .environment(MusicPlayerManager())
    }
}
