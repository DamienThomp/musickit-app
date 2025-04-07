//
//  MusicKitLibraryService.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-04-06.
//

import MusicKit

class MusicKitLibraryService: MusicLibraryProvider {

    func isInLibrary<T>(
        for item: T,
        idKeyPath: KeyPath<T.LibraryFilter, MusicItemID>
    ) async throws -> Bool where T: MusicLibraryRequestable {

        let response = try await libraryRequest(for: item, idKeyPath: idKeyPath)

        return !response.items.isEmpty
    }
    
    func libraryRequest<T>(
        for item: T,
        idKeyPath: KeyPath<T.LibraryFilter, MusicItemID>
    ) async throws -> MusicLibraryResponse<T> where T: MusicLibraryRequestable {

        var request = MusicLibraryRequest<T>()

        request.filter(matching: idKeyPath, equalTo: item.id)

        let response = try await request.response()

        return response
    }

    func addToLibrary<T: MusicItem & MusicLibraryAddable>(_ item: T) async throws {

        let library = MusicLibrary.shared

        try await library.add(item)
    }
}
