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

    // Player
    case play = "play.fill"
    case pause = "pause.fill"
    case skipForward = "forward.fill"
    case skipBack = "backward.fill"
    case shuffle = "shuffle"
    case volumeUp = "speaker.wave.3.fill"
    case volumeDown = "speaker.fill"

    // Menu
    case playNext = "text.line.first.and.arrowtriangle.forward"
    case playLast = "text.line.last.and.arrowtriangle.forward"
    case musicNoteList = "music.note.list"
    case plus = "plus"

    // Misc
    case ellipsis = "ellipsis"
    case minus = "minus"
    case checkmarkCircle = "checkmark.circle.fill"
    case plusCircle = "plus.circle"
    case circle = "circle.fill"
}
