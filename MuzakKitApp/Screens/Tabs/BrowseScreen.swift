//
//  BrowseScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-22.
//

import SwiftUI
import MusicKit

struct BrowseScreen: View {

    @Environment(MusicPlayerService.self) private var musicPlayer

    @State var recommendations: MusicItemCollection<MusicPersonalRecommendation>?

    var body: some View {

        GeometryReader {

            let width = $0.size.width

            List {

                if let recommendations {

                    ForEach(recommendations, id: \.self) { section in

                        Section {

                            if let title = section.title {
                                Text(title)
                                    .sectionHeader()
                            }

                            if let reason = section.reason {
                                Text(reason)
                                    .sectionSubtitle()
                            }

                            if !section.items.isEmpty {

                                HorizontalGrid(
                                    grid: 2.4,
                                    rows: 1,
                                    gutterSize: 12,
                                    viewAligned: false,
                                    width: width
                                ) { width in
                                    ForEach(section.items, id: \.self) { item in
                                        renderCard(for: item, with: width)
                                            .tint(.primary)
                                    }
                                }.horizontalDefaultInsets()
                            }
                        }.listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Browse")
        .onAppear {
            getMusic()
        }
    }

    @ViewBuilder
    private func renderCard(for item: MusicPersonalRecommendation.Item, with width: CGFloat) -> some View {

        switch item.self {
        case .album(let album):

            NavigationLink(value: album) {
                AlbumItemCell(item: album, size: width)
            }
        case .playlist(let playlist):

            NavigationLink(value: playlist) {
                PlaylistItemCell(item: playlist, size: width)
            }
        case .station(let station):

            StationItemCell(item: station, size: width)
                .onTapGesture {
                    playStation(station)
                }
        @unknown default:
            Text("Unknown View")
        }
    }
}

extension BrowseScreen {

    private func playStation(_ station: Station) {
        musicPlayer.handlePlayback(for: station)
    }

    private func getMusic() {

        Task {
            do {
                let recommendationsRequest = MusicPersonalRecommendationsRequest()
                let recommendations = try await recommendationsRequest.response()
                update(with: recommendations)
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    private func update(with items: MusicPersonalRecommendationsResponse) {
        withAnimation {
            self.recommendations = items.recommendations
        }
    }
}

#Preview {
    AppRootNavigation {
        BrowseScreen()
    }
    .environment(NavPath())
    .environment(MusicPlayerService())
}
