//
//  DebounceHelper.swift
//  MuzakKitApp
//
//  Created by Damien L Thompson on 2025-01-23.
//

import Foundation
import Combine

@Observable
class DebounceHelper {

    private var inputSubject = PassthroughSubject<String?, Never>()
    private var cancellables = Set<AnyCancellable>()

    var output: String = ""

    init() {
        configure()
    }

    private func configure() {
        inputSubject
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let query else { return }
                self?.output = query
            }
            .store(in: &cancellables)
    }

    func send(_ text: String) {
        inputSubject.send(text)
    }

    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
