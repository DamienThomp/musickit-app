//
//  TimerDurationFormat.swift
//  CoreDataBudgetApp
//
//  Created by Damien L Thompson on 2025-01-15.
//

import Foundation
import SwiftUI

struct TimerDurationFormat: FormatStyle {

    var style: DateComponentsFormatter.UnitsStyle

    func format(_ value: TimeInterval) -> String {

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = style
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: value) ?? ""
    }
}

extension FormatStyle where Self == TimerDurationFormat {

    static func duration(style: DateComponentsFormatter.UnitsStyle) -> Self {
        TimerDurationFormat(style: style)
    }
}

extension DateComponentsFormatter.UnitsStyle: Codable, @retroactive Hashable {}
