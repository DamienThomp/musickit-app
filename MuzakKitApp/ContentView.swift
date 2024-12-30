//
//  ContentView.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2024-12-22.
//

import SwiftUI
import MusicKit

struct ContentView: View {

    @State var recommendations: MusicItemCollection<MusicPersonalRecommendation>?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {

                if let recommendations = recommendations {
                    ForEach(recommendations, id: \.self) { recommendation in

                        VStack(alignment: .leading) {
                            if let title = recommendation.title {
                                Text(title)
                                    .padding(.leading)
                                    .font(.system(.title2))
                            }

                            if let reason = recommendation.reason {
                                Text(reason)
                                    .padding(.leading)
                                    .font(.system(.caption))
                                    .foregroundStyle(.secondary)
                            }

                            if !recommendation.items.isEmpty {
                                let items = recommendation.items
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHGrid(
                                        rows: [GridItem(
                                            .adaptive(
                                                minimum: 200,
                                                maximum: 250
                                            )
                                        )],
                                        alignment: .top,
                                        spacing: 12
                                    ) {
                                        ForEach(items, id: \.self) { item in
                                            NavigationLink(value: item) {
                                                itemCard(item: item, size: 168)
                                            }.tint(.primary)
                                        }
                                    }.padding(.leading)
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


    func itemCard(item: MusicPersonalRecommendation.Item, size: CGFloat) -> some View {
        VStack(alignment: .leading) {
            if let artwork = item.artwork {
                ArtworkImage(artwork, width: size, height: size)
                    .cornerRadius(8)
            } else {
                Image(systemName: "music.mic")
                    .resizable()
                    .foregroundStyle(.pink)
                    .background(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: size, height: size)
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
