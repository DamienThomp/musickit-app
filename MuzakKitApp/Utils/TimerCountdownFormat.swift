//
//  TimerCountdownFormat.swift
//  CoreDataBudgetApp
//
//  Created by Damien L Thompson on 2025-01-15.
//

import Foundation
import SwiftUI

struct TimerCountdownFormat: FormatStyle {

    func format(_ value: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: value) ?? ""
    }
}

extension FormatStyle where Self == TimerCountdownFormat {
    static var timerCountdown: TimerCountdownFormat { TimerCountdownFormat() }
}
