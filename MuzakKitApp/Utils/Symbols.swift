//
//  Symbols.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-17.
//

import SFSymbolsMacro
import SwiftUI

@SFSymbol
enum Symbols: String {

    // Tabs
    case browse = "square.grid.2x2.fill"
    case search = "magnifyingglass"

    // MusicItem
    case albumPlaceholder = "waveform.circle"
    case artistPlaceholder = "person.2.circle"
    case playlistPlaceholder = "recordingtape.circle"

    // Player
    case play = "play.fill"
    case pause = "pause.fill"
    case skipForward = "forward.fill"
    case skipBack = "backward.fill"
    case shuffle
    case volumeUp = "speaker.wave.3.fill"
    case volumeDown = "speaker.fill"
    case menu = "ellipsis.circle"

    // Menu
    case playNext = "text.line.first.and.arrowtriangle.forward"
    case playLast = "text.line.last.and.arrowtriangle.forward"
    case musicNoteList = "music.note.list"
    case plus

    // Misc
    case ellipsis
    case minus
    case waveform
    case checkmarkCircle = "checkmark.circle.fill"
    case plusCircle = "plus.circle"
    case circle = "circle.fill"
    case warning = "exclamationmark.triangle.fill"
    case chevronBack = "chevron.backward"
    case musicMic = "music.mic"
    case squareStack = "square.stack"
    case guitars
    case checkMarkCircle = "checkmark.circle"
}
