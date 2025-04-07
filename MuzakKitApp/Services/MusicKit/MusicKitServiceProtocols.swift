//
//  Protocols.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-04-06.
//
import MusicKit

protocol MusicAuthorizationProvider {

    var currentStatus: MusicAuthorization.Status { get }
    var subscriptionUpdates: MusicSubscription.Updates { get }

    func requestAuthorization() async -> MusicAuthorization.Status
}

protocol MusicDataFetching {
    func getData<T>(
        for item: T,
        with properties: [PartialMusicAsyncProperty<T>]
    ) async throws -> T where T: MusicItem & Decodable & MusicPropertyContainer
}

protocol MusicLibraryProvider {

    func addToLibrary<T: MusicItem & MusicLibraryAddable>(_ item: T) async throws

    func isInLibrary<T>(
        for item: T,
        idKeyPath: KeyPath<T.LibraryFilter, MusicItemID>
    ) async throws -> Bool where T: MusicItem & MusicLibraryRequestable

    func libraryRequest<T>(
        for item: T,
        idKeyPath: KeyPath<T.LibraryFilter, MusicItemID>
    ) async throws -> MusicLibraryResponse<T> where T: MusicItem & MusicLibraryRequestable
}

protocol MusicSearchProvider {

    func searchCatalog(with searchText: String) async throws -> MusicCatalogSearchResponse
    func searchLibrary(with searchText: String, for types: [any MusicLibrarySearchable.Type]) async throws -> MusicLibrarySearchResponse
}

protocol MusicServiceFactoryProtocol {
    static func create() -> MusicKitService
}
