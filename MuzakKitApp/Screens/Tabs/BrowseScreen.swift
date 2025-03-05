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
    @Environment(NavPath.self) private var navigation

    var body: some View {

        GeometryReader {

            let width = $0.size.width

            LoadingContainerView(loadingAction: fetchData) { recommendations in

                List {

                    ForEach(recommendations, id: \.self) { section in

                        Section {

                            VStack(alignment: .leading) {

                                if let title = section.title {
                                    Text(title)
                                        .sectionHeader()
                                }

                                if let reason = section.reason {
                                    Text(reason)
                                        .sectionSubtitle()
                                }
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
                .listStyle(.plain)
            }
        }
        .navigationTitle("Browse")
    }

    @ViewBuilder
    private func renderCard(for item: MusicPersonalRecommendation.Item, with width: CGFloat) -> some View {

        switch item.self {
        case .album(let album):

            AlbumItemCell(item: album, size: width)
                .onTapGesture {
                    navigation.path
                        .append(
                            AppRootScreen.DetailsView.album(album)
                        )
                }
        case .playlist(let playlist):

            PlaylistItemCell(item: playlist, size: width)
                .onTapGesture {
                    navigation.path
                        .append(
                            AppRootScreen.DetailsView.playlist(playlist)
                        )
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

    private func fetchData() async throws -> MusicItemCollection<MusicPersonalRecommendation> {

        let recommendationsRequest = MusicPersonalRecommendationsRequest()
        let response = try await recommendationsRequest.response()

        return response.recommendations
    }
}

#Preview {
    AppRootNavigation {
        BrowseScreen()
    }
    .environment(NavPath())
    .environment(MusicPlayerService())
    .environment(MusicKitService())
}
