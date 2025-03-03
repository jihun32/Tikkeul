//
//  DependencyUpdateTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/17/25.
//

import Foundation

import ComposableArchitecture

private enum UpdateTikkeulUseCaseKey: DependencyKey {
    static let liveValue: UpdateTikkeulUseCaseProtocol = UpdateTikkeulUseCase(
        repository: TikkeulRepository(
            persistenceController: .liveValue
        )
    )
}


extension DependencyValues {
    var updateTikkeulUseCase: UpdateTikkeulUseCaseProtocol {
        get { self[UpdateTikkeulUseCaseKey.self] }
        set { self[UpdateTikkeulUseCaseKey.self] = newValue }
    }
}



