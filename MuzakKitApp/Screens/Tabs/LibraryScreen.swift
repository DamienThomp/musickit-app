//
//  LibraryScreen.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-06.
//

import SwiftUI
import MusicKit

struct LibraryScreen: View {

    @Environment(NavPath.self) private var navigation

    var body: some View {

        GeometryReader { geometry in

            let width = (geometry.size.width / 2) - 24

            LoadingContainerView(loadingAction: fetchData) { items in

                List {

                    ForEach(
                        AppRootScreen.LibraryList.allCases,
                        id: \.id
                    ) { item in

                        NavigationLink(value: item) {
                            HStack {
                                Image(systemName: item.icon)
                                    .frame(minWidth: 30)
                                    .imageScale(.large)
                                    .foregroundStyle(.pink)
                                    .padding(.horizontal, 6)
                                Text(item.title).font(.title2)
                            }
                        }
                    }

                    Text("Recently Added")
                        .sectionHeader()
                        .padding(.top, 14)

                    LazyVGrid(
                        columns: [
                            GridItem(spacing: 12),
                            GridItem(spacing: 12)
                        ],
                        alignment: .center,
                        spacing: 24
                    ) {
                        ForEach(items, id: \.id) { item in

                            AlbumItemCell(item: item, size: width)
                                .onTapGesture {
                                    navigation.path.append(item)
                                }
                                .id(item.id)
                        }
                    }.listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        }
        .navigationTitle("Library")
    }
}

extension LibraryScreen {

    private func fetchData() async throws -> MusicItemCollection<Album> {

        var request: MusicLibraryRequest<Album> = MusicLibraryRequest()
        request.limit = 26
        request.sort(by: \.libraryAddedDate, ascending: false)

        let albumResponse = try await request.response()

        return albumResponse.items
    }
}

#Preview {
    AppRootNavigation {
        LibraryScreen()
    }
    .environment(MusicKitService())
    .environment(MusicPlayerService())
    .environment(NavPath())
}
