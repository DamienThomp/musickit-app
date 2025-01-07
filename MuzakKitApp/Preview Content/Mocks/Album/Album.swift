//
//  Album.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-07.
//

import Foundation
import MusicKit

let albumJSON = """
        {
            "id": "420783673600460988",
            "meta": {
                "musicKit_identifierSet": {
                    "isLibrary": true,
                    "dataSources": [
                        "localLibrary",
                        "legacyModel"
                    ],
                    "type": "Album",
                    "catalogID": {
                        "value": "480159141",
                        "kind": "adamID"
                    },
                    "id": "420783673600460988",
                    "deviceLocalID": {
                        "databaseID": "512DDBEE-11E5-461D-BBCB-EA615CF5B52F",
                        "value": "420783673600460988"
                    }
                }
            },
            "type": "library-albums",
            "attributes": {
                "audioVariants": [
                    "lossless"
                ],
                "artistName": "DoMakeSayThink",
                "genreNames": [

                ],
                "isAppleDigitalMaster": false,
                "contentRating": "clean",
                "name": "Goodbye Enemy Airship the Landlord Is Dead",
                "artwork": {
                    "textColor3": "212329",
                    "textColor2": "0A0806",
                    "height": 0,
                    "bgColor": "8995B7",
                    "url": "musicKit://artwork/library/512DDBEE-11E5-461D-BBCB-EA615CF5B52F/{w}x{h}?aat=Music%2Fea%2Fc1%2F47%2Fmzi%2Exqebcvvk%2Ejpg&at=item&fat=&id=3204433558678335059&lid=512DDBEE%2D11E5%2D461D%2DBBCB%2DEA615CF5B52F&mt=music",
                    "textColor1": "070706",
                    "width": 0
                },
                "isPrerelease": false,
                "playParams": {
                    "catalogId": "480159141",
                    "kind": "album",
                    "isLibrary": true,
                    "id": "420783673600460988",
                    "musicKit_databaseID": "512DDBEE-11E5-461D-BBCB-EA615CF5B52F",
                    "musicKit_persistentID": "420783673600460988"
                },
                "isCompilation": false,
                "trackCount": 7,
                "releaseDate": "2000-03-13"
            }
        }
""".data(using: .utf8)

var albumMock: Album? {

    guard let data = albumJSON else { return nil }
    do {
        let decoded = try JSONDecoder().decode(Album.self, from: data)
        return decoded
    } catch {
        print(error.localizedDescription)
        return nil
    }
}
