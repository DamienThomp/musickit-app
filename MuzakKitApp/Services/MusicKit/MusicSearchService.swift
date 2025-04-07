//
//  MusicSearchService.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-04-06.
//

import MusicKit

class MusicSearchService: MusicSearchProvider {

    func searchCatalog(with searchText: String) async throws -> MusicCatalogSearchResponse {

        let searchRequest = MusicCatalogSearchRequest(
            term: searchText,
            types: [
                Album.self,
                Song.self,
                Playlist.self,
                Station.self,
                Artist.self
            ]
        )

        let response = try await searchRequest.response()

        return response
    }

    func searchLibrary(
        with searchText: String,
        for types: [any MusicLibrarySearchable.Type]
    ) async throws -> MusicLibrarySearchResponse {

        let searchRequest = MusicLibrarySearchRequest(term: searchText, types: types)

        let response = try await searchRequest.response()

        return response
    }
}
