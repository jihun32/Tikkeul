//
//  DependencyAddTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/14/25.
//

import Foundation

import ComposableArchitecture

private enum AddTikkeulUseCaseKey: DependencyKey {
    static let liveValue: AddTikkeulUseCaseProtocol = AddTikkeulUseCase(
        repository: TikkeulRepository(
            persistenceController: .liveValue
        )
    )
}


extension DependencyValues {
    var addTikkeulUseCase: AddTikkeulUseCaseProtocol {
        get { self[AddTikkeulUseCaseKey.self] }
        set { self[AddTikkeulUseCaseKey.self] = newValue }
    }
}


