//
//  MusicDataFetcher.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-04-06.
//

import MusicKit

class MusicDataFetcher: MusicDataFetching {

    func getData<T>(
        for item: T,
        with properties: [PartialMusicAsyncProperty<T>]
    ) async throws -> T where T: MusicItem & Decodable & MusicPropertyContainer {

        let response = try await item.with(properties)

        return response
    }
}
