//
//  ContentView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-22.
//

import SwiftUI
import MusicKit

struct ContentView: View {

    @State var albums: MusicCatalogChart<Album>?
    @State var songs: MusicRecentlyPlayedResponse<Song>?

    @State var recommendations: MusicItemCollection<MusicPersonalRecommendation>?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                if let recommendations = recommendations {
                    ForEach(recommendations, id: \.self) { recommendation in

                        VStack(alignment: .leading) {
                            if let title = recommendation.title {
                                Text(title).font(.system(.title2))
                            }

                            if let reason = recommendation.reason {
                                Text(reason)
                                    .font(.system(.caption))
                                    .foregroundStyle(.mint)
                            }

                            if !recommendation.items.isEmpty {
                              let items = recommendation.items

                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHGrid(rows: [GridItem(.flexible(minimum: 200, maximum: 250))], spacing: 12) {
                                        ForEach(items, id: \.self) { item in
                                            card(item: item, size: 180).onTapGesture {
                                                getItemInfo(item)
                                            }
                                        }
                                    }.scrollTargetLayout()
                                }.scrollTargetBehavior(.viewAligned)
                            }
                        }
                    }
                }
            }
            .padding(.leading)
            .task {
                await fetchLibrary()
            }
        }.navigationTitle("Browse")
    }

    func getItemInfo(_ item: MusicPersonalRecommendation.Item) {
        
        switch item.self {
        case .album(let album):
            print(album)
        case .playlist(let playlist):
            print(playlist)
        case .station(let station):
            print(station)
        @unknown default:
            print("do nothing")
        }
    }

    func card(item: MusicPersonalRecommendation.Item, size: CGFloat) -> some View {
        VStack(alignment: .leading) {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .cornerRadius(8)
            }
            Text(item.title)
                .font(.system(.subheadline))
                .lineLimit(1)

            if let subtitle = item.subtitle {
                Text(subtitle)
                    .font(.system(.caption2))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }.frame(maxWidth: size)
    }

    private func getMusic() {
        Task { @MainActor in
            do {
                let recommendationsRequest = MusicPersonalRecommendationsRequest()
                let recommendations = try await recommendationsRequest.response()

                print(String(describing: recommendations))

                self.recommendations = recommendations.recommendations

                let request = MusicCatalogChartsRequest(types: [Album.self, Song.self])
                let response = try await request.response()

                self.albums = response.albumCharts.first
               // print(String(describing: response))

//                let newRequest = MusicRecentlyPlayedRequest<Song>()
//                let newResponse = try await newRequest.response()
//                print(String(describing: newResponse))
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
    ContentView()
}
