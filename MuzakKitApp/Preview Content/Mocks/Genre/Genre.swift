//
//  Genre.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-11.
//

import Foundation
import MusicKit

// swiftlint:disable:next line_length
let genreMockJson = Data("{\"data\":[{\"meta\":{\"musicKit_identifierSet\":{\"catalogID\":{\"value\":\"51\",\"kind\":\"adamID\"},\"id\":\"51\",\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"isLibrary\":false}},\"id\":\"51\",\"attributes\":{\"parentId\":\"14\",\"name\":\"K-Pop\",\"parentName\":\"Pop\"},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/51\",\"type\":\"genres\"},{\"type\":\"genres\",\"id\":\"34\",\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Genre\",\"id\":\"34\",\"dataSources\":[\"catalog\"],\"catalogID\":{\"value\":\"34\",\"kind\":\"adamID\"},\"isLibrary\":false}},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/34\",\"attributes\":{\"name\":\"Music\"}},{\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"id\":\"22\",\"type\":\"Genre\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"22\"},\"dataSources\":[\"catalog\"]}},\"type\":\"genres\",\"id\":\"22\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/22\",\"attributes\":{\"parentName\":\"Music\",\"name\":\"Inspirational\",\"parentId\":\"34\"}},{\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"catalogID\":{\"value\":\"4\",\"kind\":\"adamID\"},\"id\":\"4\",\"type\":\"Genre\",\"dataSources\":[\"catalog\"]}},\"attributes\":{\"parentName\":\"Music\",\"name\":\"Children\'s Music\",\"parentId\":\"34\"},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/4\",\"id\":\"4\",\"type\":\"genres\"},{\"id\":\"8\",\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"catalogID\":{\"kind\":\"adamID\",\"value\":\"8\"},\"id\":\"8\",\"type\":\"Genre\",\"dataSources\":[\"catalog\"]}},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/8\",\"attributes\":{\"parentName\":\"Music\",\"name\":\"Holiday\",\"parentId\":\"34\"},\"type\":\"genres\"},{\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Genre\",\"dataSources\":[\"catalog\"],\"catalogID\":{\"value\":\"1153\",\"kind\":\"adamID\"},\"id\":\"1153\",\"isLibrary\":false}},\"id\":\"1153\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/1153\",\"attributes\":{\"parentName\":\"Rock\",\"name\":\"Metal\",\"parentId\":\"21\"},\"type\":\"genres\"},{\"type\":\"genres\",\"meta\":{\"musicKit_identifierSet\":{\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"id\":\"14\",\"isLibrary\":false,\"catalogID\":{\"value\":\"14\",\"kind\":\"adamID\"}}},\"attributes\":{\"name\":\"Pop\",\"parentId\":\"34\",\"parentName\":\"Music\"},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/14\",\"id\":\"14\"},{\"id\":\"21\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/21\",\"attributes\":{\"parentName\":\"Music\",\"name\":\"Rock\",\"parentId\":\"34\"},\"meta\":{\"musicKit_identifierSet\":{\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"catalogID\":{\"value\":\"21\",\"kind\":\"adamID\"},\"id\":\"21\",\"isLibrary\":false}},\"type\":\"genres\"},{\"id\":\"20\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/20\",\"type\":\"genres\",\"attributes\":{\"parentName\":\"Music\",\"parentId\":\"34\",\"name\":\"Alternative\"},\"meta\":{\"musicKit_identifierSet\":{\"id\":\"20\",\"isLibrary\":false,\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"20\"}}}},{\"id\":\"19\",\"attributes\":{\"name\":\"Worldwide\",\"parentId\":\"34\",\"parentName\":\"Music\"},\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Genre\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"19\"},\"id\":\"19\",\"dataSources\":[\"catalog\"],\"isLibrary\":false}},\"type\":\"genres\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/19\"},{\"id\":\"17\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/17\",\"meta\":{\"musicKit_identifierSet\":{\"catalogID\":{\"value\":\"17\",\"kind\":\"adamID\"},\"isLibrary\":false,\"type\":\"Genre\",\"id\":\"17\",\"dataSources\":[\"catalog\"]}},\"type\":\"genres\",\"attributes\":{\"parentId\":\"34\",\"name\":\"Dance\",\"parentName\":\"Music\"}},{\"id\":\"15\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/15\",\"attributes\":{\"parentId\":\"34\",\"name\":\"R&B\\/Soul\",\"parentName\":\"Music\"},\"type\":\"genres\",\"meta\":{\"musicKit_identifierSet\":{\"id\":\"15\",\"type\":\"Genre\",\"catalogID\":{\"value\":\"15\",\"kind\":\"adamID\"},\"dataSources\":[\"catalog\"],\"isLibrary\":false}}},{\"attributes\":{\"parentName\":\"Music\",\"parentId\":\"34\",\"name\":\"Electronic\"},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/7\",\"meta\":{\"musicKit_identifierSet\":{\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"id\":\"7\",\"isLibrary\":false,\"catalogID\":{\"kind\":\"adamID\",\"value\":\"7\"}}},\"id\":\"7\",\"type\":\"genres\"},{\"id\":\"5\",\"meta\":{\"musicKit_identifierSet\":{\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"id\":\"5\",\"isLibrary\":false,\"catalogID\":{\"kind\":\"adamID\",\"value\":\"5\"}}},\"type\":\"genres\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/5\",\"attributes\":{\"name\":\"Classical\",\"parentName\":\"Music\",\"parentId\":\"34\"}},{\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"18\"},\"id\":\"18\"}},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/18\",\"attributes\":{\"name\":\"Hip-Hop\\/Rap\",\"parentName\":\"Music\",\"parentId\":\"34\"},\"id\":\"18\",\"type\":\"genres\"},{\"attributes\":{\"parentName\":\"Music\",\"name\":\"Latin\",\"parentId\":\"34\"},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/12\",\"type\":\"genres\",\"id\":\"12\",\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"catalogID\":{\"kind\":\"adamID\",\"value\":\"12\"},\"type\":\"Genre\",\"dataSources\":[\"catalog\"],\"id\":\"12\"}}},{\"attributes\":{\"parentId\":\"34\",\"parentName\":\"Music\",\"name\":\"Reggae\"},\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Genre\",\"id\":\"24\",\"dataSources\":[\"catalog\"],\"catalogID\":{\"value\":\"24\",\"kind\":\"adamID\"},\"isLibrary\":false}},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/24\",\"type\":\"genres\",\"id\":\"24\"},{\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/6\",\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Genre\",\"isLibrary\":false,\"id\":\"6\",\"catalogID\":{\"value\":\"6\",\"kind\":\"adamID\"},\"dataSources\":[\"catalog\"]}},\"type\":\"genres\",\"id\":\"6\",\"attributes\":{\"parentId\":\"34\",\"parentName\":\"Music\",\"name\":\"Country\"}},{\"type\":\"genres\",\"meta\":{\"musicKit_identifierSet\":{\"id\":\"50000064\",\"dataSources\":[\"catalog\"],\"isLibrary\":false,\"catalogID\":{\"value\":\"50000064\",\"kind\":\"adamID\"},\"type\":\"Genre\"}},\"id\":\"50000064\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/50000064\",\"attributes\":{\"parentId\":\"34\",\"name\":\"Musique francophone\",\"parentName\":\"Music\"}},{\"type\":\"genres\",\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/16\",\"attributes\":{\"parentName\":\"Music\",\"parentId\":\"34\",\"name\":\"Soundtrack\"},\"meta\":{\"musicKit_identifierSet\":{\"catalogID\":{\"value\":\"16\",\"kind\":\"adamID\"},\"isLibrary\":false,\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"id\":\"16\"}},\"id\":\"16\"},{\"attributes\":{\"parentId\":\"34\",\"parentName\":\"Music\",\"name\":\"Singer\\/Songwriter\"},\"href\":\"\\/v1\\/catalog\\/ca\\/genres\\/10\",\"type\":\"genres\",\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"catalogID\":{\"kind\":\"adamID\",\"value\":\"10\"},\"dataSources\":[\"catalog\"],\"type\":\"Genre\",\"id\":\"10\"}},\"id\":\"10\"}]}".utf8)

var genreMock: MusicCatalogResourceResponse<Genre>? {

    do {
        return try JSONDecoder().decode(MusicCatalogResourceResponse<Genre>.self, from: genreMockJson)
    } catch {
        print(error.localizedDescription)
        return nil
    }
}
