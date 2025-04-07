//
//  MusicKitServiceFactory.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-04-06.
//

import Foundation

class MusicKitServiceFactory: MusicServiceFactoryProtocol {

    static func create() -> MusicKitService {

        let auth = MusicKitAuthService()
        let dataFetching = MusicDataFetcher()
        let search = MusicSearchService()
        let library = MusicKitLibraryService()
        
        return MusicKitService(
            auth: auth,
            dataFetching: dataFetching,
            search: search,
            library: library
        )
    }
}
