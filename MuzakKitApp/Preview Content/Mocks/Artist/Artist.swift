//
//  Artist.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-19.
//
import MusicKit
import Foundation

let artistJson = Data("{\"relationships\":{\"albums\":{\"data\":[{\"id\":\"1438252159\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1438252159\",\"meta\":{\"musicKit_identifierSet\":{\"preferredIdentifierKind\":\"catalogID\",\"type\":\"Album\",\"isLibrary\":false,\"catalogID\":{\"value\":\"1438252159\",\"kind\":\"adamID\"},\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"id\":\"1438252159\"}},\"type\":\"albums\",\"attributes\":{\"isComplete\":true,\"name\":\"Suicide\",\"artistName\":\"Suicide\",\"contentRating\":\"clean\",\"artwork\":{\"bgColor\":\"ffffff\",\"width\":4000,\"textColor2\":\"1a0907\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music211\\/v4\\/fc\\/d8\\/f6\\/fcd8f63b-fef7-98a2-824e-6a28ffde889a\\/4050538253627.jpg\\/{w}x{h}bb.jpg\",\"textColor3\":\"403736\",\"textColor4\":\"483a38\",\"textColor1\":\"100504\",\"height\":4000},\"isSingle\":false,\"isAppleDigitalMaster\":true,\"audioVariants\":[],\"releaseDate\":\"2017-07-21\",\"trackCount\":7,\"playParams\":{\"id\":\"1438252159\",\"kind\":\"album\",\"catalogId\":\"1438252159\"},\"isCompilation\":false,\"genreNames\":[\"Rock\",\"Music\"],\"copyright\":\"℗ 2019 Revega Music Company, under exclusive licence to Mute Records Ltd., a BMG Company\",\"recordLabel\":\"Mute, a BMG Company\",\"upc\":\"4050538253627\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/suicide\\/1438252159\"}},{\"id\":\"1435782281\",\"meta\":{\"musicKit_identifierSet\":{\"preferredIdentifierKind\":\"catalogID\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"isLibrary\":false,\"catalogID\":{\"value\":\"1435782281\",\"kind\":\"adamID\"},\"type\":\"Album\",\"id\":\"1435782281\"}},\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1435782281\",\"attributes\":{\"artwork\":{\"bgColor\":\"ffffff\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music128\\/v4\\/0f\\/fa\\/a4\\/0ffaa418-4fa0-11b4-5d7a-b5e722205d45\\/0724386350053.jpg\\/{w}x{h}bb.jpg\",\"textColor2\":\"1e1e1e\",\"textColor3\":\"393939\",\"textColor4\":\"4b4b4b\",\"textColor1\":\"080808\",\"height\":1400,\"width\":1400},\"releaseDate\":\"1988-01-01\",\"genreNames\":[\"Electronic\",\"Music\"],\"upc\":\"0724386350053\",\"audioVariants\":[],\"isAppleDigitalMaster\":false,\"isSingle\":false,\"recordLabel\":\"Mute, a BMG Company\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/a-way-of-life-2005-remaster\\/1435782281\",\"playParams\":{\"kind\":\"album\",\"catalogId\":\"1435782281\",\"id\":\"1435782281\"},\"artistName\":\"Suicide\",\"name\":\"A Way of Life (2005 - Remaster)\",\"contentRating\":\"clean\",\"isCompilation\":false,\"isComplete\":true,\"copyright\":\"℗ 2005 Suicide under exclusive licence to Mute Records Ltd., a BMG Company\",\"trackCount\":9},\"type\":\"albums\"},{\"attributes\":{\"audioVariants\":[],\"name\":\"The Second Album + the First Rehearsal Tapes\",\"upc\":\"0094638647157\",\"isCompilation\":true,\"isComplete\":true,\"isAppleDigitalMaster\":false,\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/the-second-album-the-first-rehearsal-tapes\\/1439695951\",\"contentRating\":\"clean\",\"playParams\":{\"id\":\"1439695951\",\"kind\":\"album\",\"catalogId\":\"1439695951\"},\"isSingle\":false,\"artwork\":{\"bgColor\":\"fefafb\",\"textColor2\":\"0f0e0f\",\"textColor4\":\"3f3d3e\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music128\\/v4\\/cb\\/1a\\/50\\/cb1a50db-9e6a-0754-a23d-f7c81ff2e4e1\\/0094638647157.jpg\\/{w}x{h}bb.jpg\",\"textColor3\":\"363535\",\"width\":1400,\"textColor1\":\"040404\",\"height\":1400},\"trackCount\":27,\"copyright\":\"℗ 1999 Suicide under exclusive licence to Mute Records Ltd., a BMG Company\",\"genreNames\":[\"Electronic\",\"Music\",\"Alternative\",\"Punk\",\"Classical\",\"Modern Era\"],\"artistName\":\"Suicide\",\"recordLabel\":\"Mute, a BMG Company\"},\"id\":\"1439695951\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1439695951\",\"type\":\"albums\",\"meta\":{\"musicKit_identifierSet\":{\"catalogID\":{\"value\":\"1439695951\",\"kind\":\"adamID\"},\"isLibrary\":false,\"id\":\"1439695951\",\"preferredIdentifierKind\":\"catalogID\",\"type\":\"Album\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"]}}},{\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Album\",\"catalogID\":{\"value\":\"1463179848\",\"kind\":\"adamID\"},\"id\":\"1463179848\",\"preferredIdentifierKind\":\"catalogID\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"isLibrary\":false}},\"type\":\"albums\",\"id\":\"1463179848\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1463179848\",\"attributes\":{\"audioVariants\":[],\"isCompilation\":false,\"copyright\":\"℗ 2019 Revega Music Company, under exclusive licence to Mute Records Ltd., a BMG Company\",\"artwork\":{\"textColor3\":\"423534\",\"textColor4\":\"4c3a35\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music113\\/v4\\/87\\/9c\\/62\\/879c621f-6c35-e07f-9556-995b5bd7e02d\\/4050538514346.jpg\\/{w}x{h}bb.jpg\",\"height\":4000,\"width\":4000,\"textColor1\":\"130301\",\"bgColor\":\"ffffff\",\"textColor2\":\"200903\"},\"upc\":\"4050538514346\",\"releaseDate\":\"1977-12-28\",\"name\":\"Suicide (2019 Remaster)\",\"isComplete\":true,\"isSingle\":false,\"playParams\":{\"catalogId\":\"1463179848\",\"id\":\"1463179848\",\"kind\":\"album\"},\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/suicide-2019-remaster\\/1463179848\",\"genreNames\":[\"Rock\",\"Music\"],\"contentRating\":\"clean\",\"recordLabel\":\"Mute, a BMG Company\",\"isAppleDigitalMaster\":false,\"artistName\":\"Suicide\",\"trackCount\":7}},{\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/79488839\",\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Album\",\"id\":\"79488839\",\"deviceLocalID\":{\"databaseID\":\"512DDBEE-11E5-461D-BBCB-EA615CF5B52F\",\"value\":\"6288891255543353815\"},\"preferredIdentifierKind\":\"catalogID\",\"isLibrary\":false,\"catalogID\":{\"kind\":\"adamID\",\"value\":\"79488839\"},\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"]}},\"id\":\"79488839\",\"type\":\"albums\",\"attributes\":{\"isAppleDigitalMaster\":false,\"copyright\":\"℗ 1998 Revega Music Co. (ASCAP)\",\"editorialNotes\":{\"standard\":\"Said to be the first band to bill itself as \\\"punk,\\\" Suicide didn\'t play what\'s commonly considered punk in the 21st-century definition of the word. Yet its music is far more confrontational and experimental (and therefore more punk) than many groups that make similar claims. This album was originally issued on cassette; it\'s a recording of a 1981 performance at Minneapolis\' Walker Arts Center, celebrating the duo\'s 10th anniversary. (The title track was later heavily sampled for M.I.A.\'s \\\"Born Free,\\\" further proving the band\'s enduring influence.) Featuring just keyboards, Martin Rev\'s drum machines, and Alan Vega\'s alienating vocals, Suicide influenced an entire generation of synth and industrial bands. (Even Bruce Springsteen, who\'s admitted a spiritual affinity for the humanist struggle hidden in Suicide\'s music, covered \\\"Dream Baby Dream.\\\") To virgin ears, this is tough-sounding music; its logic takes repeated plays to comprehend. (Keep in mind, this isn\'t even the band at its most abrasive!)\"},\"isCompilation\":false,\"artistName\":\"Suicide\",\"audioVariants\":[],\"recordLabel\":\"ROIR\",\"isSingle\":false,\"name\":\"Ghost Riders\",\"playParams\":{\"musicKit_databaseID\":\"512DDBEE-11E5-461D-BBCB-EA615CF5B52F\",\"id\":\"79488839\",\"catalogId\":\"79488839\",\"kind\":\"album\",\"musicKit_persistentID\":\"6288891255543353815\"},\"contentRating\":\"clean\",\"trackCount\":7,\"isComplete\":true,\"genreNames\":[\"Alternative\",\"Music\",\"Electronic\",\"Rock\",\"Adult Alternative\",\"Punk\",\"Classical\",\"Modern Era\"],\"artwork\":{\"textColor1\":\"ecebe9\",\"height\":600,\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Features\\/ac\\/a1\\/90\\/dj.aelsmlic.jpg\\/{w}x{h}bb.jpg\",\"textColor2\":\"cac869\",\"bgColor\":\"030608\",\"textColor3\":\"bdbdbc\",\"width\":608,\"textColor4\":\"a2a256\"},\"upc\":\"053436823927\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/ghost-riders\\/79488839\"}},{\"attributes\":{\"recordLabel\":\"ROIR\",\"isSingle\":false,\"isAppleDigitalMaster\":false,\"playParams\":{\"catalogId\":\"41311523\",\"kind\":\"album\",\"id\":\"41311523\"},\"copyright\":\"℗ 2000 Revega Music Company (ASCAP)\",\"audioVariants\":[],\"upc\":\"053436826423\",\"isCompilation\":false,\"artwork\":{\"height\":600,\"bgColor\":\"0a080b\",\"textColor3\":\"cdcdce\",\"width\":615,\"textColor2\":\"e8fafc\",\"textColor4\":\"bccacc\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Features\\/37\\/ba\\/88\\/dj.pxvjdcpo.jpg\\/{w}x{h}bb.jpg\",\"textColor1\":\"ffffff\"},\"isComplete\":true,\"name\":\"Half Alive (Live)\",\"genreNames\":[\"Rock\",\"Music\",\"Electronic\",\"Classical\",\"Modern Era\",\"Alternative\",\"Punk\",\"Adult Alternative\"],\"artistName\":\"Suicide\",\"trackCount\":15,\"contentRating\":\"clean\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/half-alive-live\\/41311523\",\"releaseDate\":\"2000-06-06\"},\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/41311523\",\"type\":\"albums\",\"meta\":{\"musicKit_identifierSet\":{\"preferredIdentifierKind\":\"catalogID\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"id\":\"41311523\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"41311523\"},\"type\":\"Album\",\"isLibrary\":false}},\"id\":\"41311523\"},{\"type\":\"albums\",\"id\":\"1436067079\",\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Album\",\"isLibrary\":false,\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"id\":\"1436067079\",\"preferredIdentifierKind\":\"catalogID\",\"catalogID\":{\"value\":\"1436067079\",\"kind\":\"adamID\"}}},\"attributes\":{\"genreNames\":[\"Electronic\",\"Music\",\"Alternative\",\"Punk\",\"Rock\",\"Adult Alternative\",\"Classical\",\"Modern Era\",\"Prog-Rock\\/Art Rock\"],\"isAppleDigitalMaster\":false,\"artistName\":\"Suicide\",\"releaseDate\":\"2002-10-28\",\"audioVariants\":[],\"copyright\":\"℗ 2002 Suicide under exclusive licence to Mute Records Ltd., a BMG Company\",\"artwork\":{\"textColor3\":\"c8c7c6\",\"textColor4\":\"b5b1af\",\"height\":1425,\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music128\\/v4\\/7d\\/d7\\/bf\\/7dd7bf56-a8ae-7e94-13ca-3e377193b378\\/0724387432550.jpg\\/{w}x{h}bb.jpg\",\"bgColor\":\"08080a\",\"textColor1\":\"f8f7f5\",\"textColor2\":\"e0dcd8\",\"width\":1425},\"trackCount\":11,\"playParams\":{\"catalogId\":\"1436067079\",\"id\":\"1436067079\",\"kind\":\"album\"},\"name\":\"American Supreme\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/american-supreme\\/1436067079\",\"contentRating\":\"clean\",\"isSingle\":false,\"recordLabel\":\"Mute, a BMG Company\",\"isCompilation\":false,\"isComplete\":true,\"upc\":\"0724387432550\"},\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1436067079\"},{\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Album\",\"catalogID\":{\"value\":\"1684448551\",\"kind\":\"adamID\"},\"isLibrary\":false,\"preferredIdentifierKind\":\"catalogID\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"id\":\"1684448551\"}},\"attributes\":{\"isComplete\":true,\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/a-way-of-life-35th-anniversary-edition-2023-remaster\\/1684448551\",\"recordLabel\":\"BMG Rights Management (UK) Ltd.\",\"releaseDate\":\"1988-01-01\",\"upc\":\"4050538821666\",\"playParams\":{\"id\":\"1684448551\",\"kind\":\"album\",\"catalogId\":\"1684448551\"},\"artistName\":\"Suicide\",\"isCompilation\":false,\"isSingle\":false,\"name\":\"A Way of Life (35th Anniversary Edition) [2023 Remaster]\",\"audioVariants\":[],\"artwork\":{\"textColor1\":\"f0ce2f\",\"bgColor\":\"141213\",\"height\":4000,\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music126\\/v4\\/09\\/a8\\/a9\\/09a8a9bb-eabc-e705-7042-b3388315b284\\/4050538821666.jpg\\/{w}x{h}bb.jpg\",\"textColor3\":\"c4a829\",\"width\":4000,\"textColor4\":\"48a0b6\",\"textColor2\":\"55c4df\"},\"isAppleDigitalMaster\":false,\"copyright\":\"℗ 2023 Revega Music Company \\/ Saturn Strip under exclusive license to Mute Records Ltd., a BMG Company\",\"contentRating\":\"clean\",\"trackCount\":13,\"genreNames\":[\"Electronic\",\"Music\"]},\"type\":\"albums\",\"id\":\"1684448551\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1684448551\"},{\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1604581885\",\"attributes\":{\"contentRating\":\"clean\",\"genreNames\":[\"Electronic\",\"Music\"],\"isSingle\":false,\"isComplete\":true,\"copyright\":\"℗ 2022 Revega Publishing Company \\/ Saturn Strip under exclusive license to Mute Records Ltd., a BMG Company\",\"playParams\":{\"catalogId\":\"1604581885\",\"kind\":\"album\",\"id\":\"1604581885\"},\"upc\":\"4050538771626\",\"isCompilation\":true,\"name\":\"Surrender\",\"recordLabel\":\"Mute, a BMG Company\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/surrender\\/1604581885\",\"artwork\":{\"textColor4\":\"474747\",\"bgColor\":\"ffffff\",\"textColor1\":\"0c0c0c\",\"height\":4000,\"width\":4000,\"textColor2\":\"191919\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music116\\/v4\\/70\\/f3\\/91\\/70f391d3-e070-3eb5-b474-e99192dddf5e\\/4050538771626.jpg\\/{w}x{h}bb.jpg\",\"textColor3\":\"3d3d3d\"},\"audioVariants\":[],\"releaseDate\":\"2022-04-08\",\"trackCount\":16,\"artistName\":\"Suicide\",\"isAppleDigitalMaster\":false},\"id\":\"1604581885\",\"meta\":{\"musicKit_identifierSet\":{\"id\":\"1604581885\",\"isLibrary\":false,\"catalogID\":{\"value\":\"1604581885\",\"kind\":\"adamID\"},\"type\":\"Album\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"preferredIdentifierKind\":\"catalogID\"}},\"type\":\"albums\"},{\"type\":\"albums\",\"attributes\":{\"artistName\":\"Suicide\",\"recordLabel\":\"Mute, a BMG Company\",\"isComplete\":true,\"audioVariants\":[],\"releaseDate\":\"2021-09-03\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/cheree-ep\\/1710201086\",\"playParams\":{\"kind\":\"album\",\"id\":\"1710201086\",\"catalogId\":\"1710201086\"},\"isAppleDigitalMaster\":false,\"isSingle\":false,\"upc\":\"4050538716177\",\"contentRating\":\"clean\",\"trackCount\":4,\"copyright\":\"℗ 2021 Revega Music Company under exclusive license to Mute Records Ltd., a BMG Company\",\"name\":\"Cheree - EP\",\"artwork\":{\"textColor4\":\"c72b49\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music116\\/v4\\/29\\/ce\\/8b\\/29ce8be9-f5b7-b198-2eac-e1cc7aa55cdf\\/4050538716177.jpg\\/{w}x{h}bb.jpg\",\"textColor3\":\"cb4978\",\"textColor1\":\"f9588e\",\"width\":4000,\"height\":4000,\"textColor2\":\"f53254\",\"bgColor\":\"120f1d\"},\"isCompilation\":false,\"genreNames\":[\"Rock\",\"Music\"]},\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1710201086\",\"id\":\"1710201086\",\"meta\":{\"musicKit_identifierSet\":{\"id\":\"1710201086\",\"catalogID\":{\"value\":\"1710201086\",\"kind\":\"adamID\"},\"isLibrary\":false,\"type\":\"Album\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"preferredIdentifierKind\":\"catalogID\"}}},{\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1678140610\",\"attributes\":{\"contentRating\":\"clean\",\"recordLabel\":\"BMG Rights Management (UK) Ltd.\",\"artistName\":\"Suicide\",\"genreNames\":[\"Electronic\",\"Music\"],\"audioVariants\":[],\"artwork\":{\"textColor4\":\"48a0b6\",\"width\":4000,\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music126\\/v4\\/0e\\/a9\\/70\\/0ea9705a-b366-9e69-77ef-e9b8d677e9c4\\/4050538919189.jpg\\/{w}x{h}bb.jpg\",\"bgColor\":\"141213\",\"textColor3\":\"c4a829\",\"textColor2\":\"55c4df\",\"height\":4000,\"textColor1\":\"f0ce2f\"},\"upc\":\"4050538919189\",\"isAppleDigitalMaster\":false,\"name\":\"Born in the USA (Single Edit - Live in Paris 1988) - Single\",\"isSingle\":true,\"isCompilation\":false,\"playParams\":{\"kind\":\"album\",\"catalogId\":\"1678140610\",\"id\":\"1678140610\"},\"isComplete\":true,\"releaseDate\":\"2023-04-05\",\"copyright\":\"℗ 2023 Revega Music Company \\/ Saturn Strip under exclusive license to Mute Records Ltd., a BMG Company\",\"trackCount\":1,\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/born-in-the-usa-single-edit-live-in-paris-1988-single\\/1678140610\"},\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"id\":\"1678140610\",\"type\":\"Album\",\"preferredIdentifierKind\":\"catalogID\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"1678140610\"}}},\"id\":\"1678140610\",\"type\":\"albums\"},{\"id\":\"293138881\",\"type\":\"albums\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/293138881\",\"attributes\":{\"releaseDate\":\"2008-11-03\",\"trackCount\":3,\"upc\":\"5060158998494\",\"contentRating\":\"clean\",\"isCompilation\":false,\"playParams\":{\"musicKit_persistentID\":\"6288891255543353815\",\"id\":\"293138881\",\"kind\":\"album\",\"musicKit_databaseID\":\"512DDBEE-11E5-461D-BBCB-EA615CF5B52F\",\"catalogId\":\"293138881\"},\"artistName\":\"The Horrors, Suicide & Nik Void\",\"copyright\":\"℗ 2008 Blast First Petite\",\"name\":\"Shadazz \\/ Radiation - EP\",\"artwork\":{\"width\":600,\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music\\/b0\\/bd\\/3b\\/mzi.zxhcuhhz.jpg\\/{w}x{h}bb.jpg\",\"textColor3\":\"3c3b3b\",\"textColor4\":\"79444c\",\"bgColor\":\"ffffff\",\"textColor2\":\"58161f\",\"height\":600,\"textColor1\":\"0b0a0a\"},\"isSingle\":false,\"isComplete\":true,\"isAppleDigitalMaster\":false,\"recordLabel\":\"Blast First Petite\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/shadazz-radiation-ep\\/293138881\",\"genreNames\":[\"Alternative\",\"Music\"],\"audioVariants\":[]},\"meta\":{\"musicKit_identifierSet\":{\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"preferredIdentifierKind\":\"catalogID\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"293138881\"},\"type\":\"Album\",\"deviceLocalID\":{\"databaseID\":\"512DDBEE-11E5-461D-BBCB-EA615CF5B52F\",\"value\":\"6288891255543353815\"},\"isLibrary\":false,\"id\":\"293138881\"}}},{\"type\":\"albums\",\"attributes\":{\"upc\":\"5060158999446\",\"audioVariants\":[],\"isComplete\":true,\"playParams\":{\"kind\":\"album\",\"catalogId\":\"298448400\",\"id\":\"298448400\"},\"isSingle\":false,\"contentRating\":\"clean\",\"isAppleDigitalMaster\":false,\"genreNames\":[\"Alternative\",\"Music\",\"Rock\",\"British Invasion\",\"Adult Alternative\"],\"releaseDate\":\"2008-12-22\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/diamonds-furcoats-champagne-ep\\/298448400\",\"trackCount\":3,\"copyright\":\"℗ 2008 Blast First Petite\",\"artwork\":{\"textColor1\":\"fbd4bd\",\"width\":600,\"bgColor\":\"646b74\",\"textColor3\":\"dcbfaf\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music\\/61\\/bc\\/e9\\/mzi.azhmhzkj.jpg\\/{w}x{h}bb.jpg\",\"textColor2\":\"fbb9a3\",\"textColor4\":\"ddaa99\",\"height\":600},\"recordLabel\":\"Blast First Petite\",\"isCompilation\":false,\"artistName\":\"Primal Scream, Suicide & Conrad Standish\",\"name\":\"Diamonds, Furcoats, Champagne - EP\"},\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"preferredIdentifierKind\":\"catalogID\",\"type\":\"Album\",\"catalogID\":{\"value\":\"298448400\",\"kind\":\"adamID\"},\"id\":\"298448400\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"]}},\"id\":\"298448400\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/298448400\"},{\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Album\",\"isLibrary\":false,\"preferredIdentifierKind\":\"catalogID\",\"id\":\"1439426786\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"catalogID\":{\"kind\":\"adamID\",\"value\":\"1439426786\"}}},\"id\":\"1439426786\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1439426786\",\"type\":\"albums\",\"attributes\":{\"genreNames\":[\"Electronic\",\"Music\",\"Rock\",\"Prog-Rock\\/Art Rock\"],\"isCompilation\":false,\"playParams\":{\"kind\":\"album\",\"catalogId\":\"1439426786\",\"id\":\"1439426786\"},\"copyright\":\"℗ 2005 Suicide under exclusive licence to Mute Records Ltd., a BMG Company\",\"audioVariants\":[],\"name\":\"Why Be Blue? (Deluxe Edition;2005 - Remaster)\",\"upc\":\"0094638647454\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/why-be-blue-deluxe-edition-2005-remaster\\/1439426786\",\"releaseDate\":\"1992-01-01\",\"isSingle\":false,\"artistName\":\"Suicide\",\"trackCount\":18,\"contentRating\":\"clean\",\"isAppleDigitalMaster\":false,\"artwork\":{\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music128\\/v4\\/23\\/76\\/6a\\/23766ac1-174f-a77a-2e82-538208491b4b\\/0094638647454.jpg\\/{w}x{h}bb.jpg\",\"height\":1400,\"textColor1\":\"4de89a\",\"bgColor\":\"b10017\",\"width\":1400,\"textColor3\":\"61b980\",\"textColor4\":\"61b980\",\"textColor2\":\"4de89a\"},\"isComplete\":true,\"recordLabel\":\"Mute, a BMG Company\"}},{\"type\":\"albums\",\"id\":\"298448981\",\"meta\":{\"musicKit_identifierSet\":{\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"preferredIdentifierKind\":\"catalogID\",\"catalogID\":{\"value\":\"298448981\",\"kind\":\"adamID\"},\"id\":\"298448981\",\"isLibrary\":false,\"type\":\"Album\"}},\"attributes\":{\"trackCount\":2,\"contentRating\":\"clean\",\"name\":\"Frankie Teardrop - Single\",\"upc\":\"5060158999453\",\"playParams\":{\"kind\":\"album\",\"id\":\"298448981\",\"catalogId\":\"298448981\"},\"genreNames\":[\"Alternative\",\"Music\",\"Rock\",\"Prog-Rock\\/Art Rock\",\"New Wave\",\"Punk\"],\"isCompilation\":false,\"isComplete\":true,\"recordLabel\":\"Blast First Petite\",\"artwork\":{\"height\":600,\"textColor3\":\"d0d1d1\",\"width\":600,\"textColor2\":\"cdd3d6\",\"bgColor\":\"1c2021\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music\\/07\\/77\\/a4\\/mzi.kvvszaer.jpg\\/{w}x{h}bb.jpg\",\"textColor4\":\"aaafb2\",\"textColor1\":\"fdfdfd\"},\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/frankie-teardrop-single\\/298448981\",\"artistName\":\"Lydia Lunch & Suicide\",\"copyright\":\"℗ 2008 Blast First Petite\",\"audioVariants\":[],\"isSingle\":false,\"isAppleDigitalMaster\":false,\"releaseDate\":\"2008-12-22\"},\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/298448981\"},{\"attributes\":{\"artistName\":\"Suicide\",\"isCompilation\":false,\"isComplete\":true,\"releaseDate\":\"2023-06-02\",\"playParams\":{\"kind\":\"album\",\"catalogId\":\"1687292602\",\"id\":\"1687292602\"},\"audioVariants\":[],\"isSingle\":false,\"genreNames\":[\"Electronic\",\"Music\"],\"recordLabel\":\"BMG Rights Management (UK) Ltd.\",\"isAppleDigitalMaster\":false,\"upc\":\"4050538936780\",\"artwork\":{\"textColor1\":\"010101\",\"textColor3\":\"343434\",\"height\":4000,\"textColor2\":\"2f2f2f\",\"width\":4000,\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music126\\/v4\\/1f\\/1a\\/13\\/1f1a138f-0113-7bb4-6e22-08b758d0d033\\/4050538936780.jpg\\/{w}x{h}bb.jpg\",\"bgColor\":\"ffffff\",\"textColor4\":\"585858\"},\"trackCount\":4,\"name\":\"A Way of Life Rarities\",\"contentRating\":\"clean\",\"copyright\":\"℗ 2023 Revega Music Company \\/ Saturn Strip under exclusive license to Mute Records Ltd., a BMG Company\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/a-way-of-life-rarities\\/1687292602\"},\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1687292602\",\"type\":\"albums\",\"id\":\"1687292602\",\"meta\":{\"musicKit_identifierSet\":{\"type\":\"Album\",\"catalogID\":{\"value\":\"1687292602\",\"kind\":\"adamID\"},\"isLibrary\":false,\"preferredIdentifierKind\":\"catalogID\",\"id\":\"1687292602\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"]}}},{\"attributes\":{\"artistName\":\"Suicide\",\"recordLabel\":\"Mute, a BMG Company\",\"contentRating\":\"clean\",\"isSingle\":false,\"isComplete\":true,\"name\":\"Why Be Blue? (2005 Remaster)\",\"playParams\":{\"id\":\"1435781213\",\"kind\":\"album\",\"catalogId\":\"1435781213\"},\"upc\":\"0724386353856\",\"releaseDate\":\"1992-01-01\",\"trackCount\":10,\"isAppleDigitalMaster\":false,\"artwork\":{\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music211\\/v4\\/79\\/15\\/11\\/791511ff-9f1c-c072-d5f4-cad50ceed256\\/0724386353856.jpg\\/{w}x{h}bb.jpg\",\"textColor2\":\"f7e5e7\",\"textColor4\":\"e9b7be\",\"textColor1\":\"fbf2f3\",\"height\":1427,\"textColor3\":\"ecc1c7\",\"width\":1427,\"bgColor\":\"b10017\"},\"isCompilation\":false,\"genreNames\":[\"Electronic\",\"Music\"],\"audioVariants\":[],\"copyright\":\"℗ 2005 Suicide under exclusive licence to Mute Records Ltd., a BMG Company\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/why-be-blue-2005-remaster\\/1435781213\"},\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1435781213\",\"type\":\"albums\",\"meta\":{\"musicKit_identifierSet\":{\"preferredIdentifierKind\":\"catalogID\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"type\":\"Album\",\"catalogID\":{\"value\":\"1435781213\",\"kind\":\"adamID\"},\"isLibrary\":false,\"id\":\"1435781213\"}},\"id\":\"1435781213\"},{\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1603038241\",\"type\":\"albums\",\"id\":\"1603038241\",\"attributes\":{\"artistName\":\"Suicide\",\"name\":\"Frankie Teardrop (First Version) (7\\\" Edit) [2022 Remaster] - Single\",\"trackCount\":1,\"copyright\":\"℗ 2022 Revega Publishing Company \\/ Saturn Strip under exclusive license to Mute Records Ltd., a BMG Company\",\"audioVariants\":[],\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/frankie-teardrop-first-version-7-edit-2022-remaster-single\\/1603038241\",\"playParams\":{\"id\":\"1603038241\",\"kind\":\"album\",\"catalogId\":\"1603038241\"},\"isComplete\":true,\"isSingle\":true,\"recordLabel\":\"Mute, a BMG Company\",\"artwork\":{\"textColor4\":\"474747\",\"width\":4000,\"bgColor\":\"ffffff\",\"textColor1\":\"0c0c0c\",\"textColor3\":\"3d3d3d\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music126\\/v4\\/c1\\/43\\/09\\/c1430997-9460-4d92-769e-a1f5fe8d922d\\/4050538775839.jpg\\/{w}x{h}bb.jpg\",\"height\":4000,\"textColor2\":\"191919\"},\"contentRating\":\"clean\",\"isAppleDigitalMaster\":false,\"releaseDate\":\"2022-01-18\",\"upc\":\"4050538775839\",\"isCompilation\":false,\"genreNames\":[\"Electronic\",\"Music\"]},\"meta\":{\"musicKit_identifierSet\":{\"catalogID\":{\"kind\":\"adamID\",\"value\":\"1603038241\"},\"id\":\"1603038241\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"isLibrary\":false,\"preferredIdentifierKind\":\"catalogID\",\"type\":\"Album\"}}},{\"id\":\"1608862984\",\"href\":\"\\/v1\\/catalog\\/ca\\/albums\\/1608862984\",\"type\":\"albums\",\"meta\":{\"musicKit_identifierSet\":{\"id\":\"1608862984\",\"type\":\"Album\",\"catalogID\":{\"value\":\"1608862984\",\"kind\":\"adamID\"},\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"],\"isLibrary\":false,\"preferredIdentifierKind\":\"catalogID\"}},\"attributes\":{\"name\":\"Dream Baby Dream - Single\",\"trackCount\":3,\"genreNames\":[\"Rock\",\"Music\"],\"isAppleDigitalMaster\":false,\"contentRating\":\"clean\",\"upc\":\"4050538785432\",\"artwork\":{\"bgColor\":\"9a9a9a\",\"width\":4000,\"textColor2\":\"171716\",\"height\":4000,\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music126\\/v4\\/43\\/9d\\/c2\\/439dc2a3-d2e5-29d2-10bb-6f3a090b3b3c\\/4050538785432.jpg\\/{w}x{h}bb.jpg\",\"textColor1\":\"060506\",\"textColor3\":\"242323\",\"textColor4\":\"313130\"},\"copyright\":\"℗ 2019 Mute Records Ltd., a BMG Company\",\"playParams\":{\"id\":\"1608862984\",\"kind\":\"album\",\"catalogId\":\"1608862984\"},\"artistName\":\"Suicide\",\"isSingle\":false,\"audioVariants\":[],\"isComplete\":true,\"recordLabel\":\"Mute, a BMG Company\",\"url\":\"https:\\/\\/music.apple.com\\/ca\\/album\\/dream-baby-dream-single\\/1608862984\",\"isCompilation\":false}}],\"href\":\"\\/v1\\/catalog\\/ca\\/artists\\/6568486\\/albums\"}},\"meta\":{\"musicKit_identifierSet\":{\"isLibrary\":false,\"deviceLocalID\":{\"value\":\"-7471507698777673600\",\"databaseID\":\"512DDBEE-11E5-461D-BBCB-EA615CF5B52F\"},\"type\":\"Artist\",\"preferredIdentifierKind\":\"catalogID\",\"catalogID\":{\"kind\":\"adamID\",\"value\":\"6568486\"},\"id\":\"6568486\",\"dataSources\":[\"catalog\",\"localLibrary\",\"legacyModel\"]}},\"href\":\"\\/v1\\/catalog\\/ca\\/artists\\/6568486\",\"id\":\"6568486\",\"type\":\"artists\",\"attributes\":{\"genreNames\":[\"Electronic\"],\"url\":\"https:\\/\\/music.apple.com\\/ca\\/artist\\/suicide\\/6568486\",\"name\":\"Suicide\",\"artwork\":{\"textColor1\":\"fafafa\",\"textColor3\":\"cccccc\",\"url\":\"https:\\/\\/is1-ssl.mzstatic.com\\/image\\/thumb\\/Music116\\/v4\\/93\\/e9\\/9a\\/93e99a28-53d2-9dec-c7c1-bffb303ce1c0\\/pr_source.png\\/{w}x{h}bb.jpg\",\"bgColor\":\"141414\",\"width\":743,\"textColor4\":\"b3b3b3\",\"textColor2\":\"dbdbdb\",\"height\":743}}}".utf8)

var artistMock: Artist? {

    do {
        return try JSONDecoder().decode(Artist.self, from: artistJson)
    } catch {
        print(error.localizedDescription)
        return nil
    }
}
