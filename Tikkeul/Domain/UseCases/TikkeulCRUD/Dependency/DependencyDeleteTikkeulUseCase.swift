//
//  DependencyDeleteTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/18/25.
//

import Foundation

import ComposableArchitecture

private enum DeleteTikkeulUseCaseKey: DependencyKey {
    static let liveValue: DeleteTikkeulUseCaseProtocol = DeleteTikkeulUseCase(
        repository: TikkeulRepository(
            persistenceController: .liveValue
        )
    )
}


extension DependencyValues {
    var deleteTikkeulUseCase: DeleteTikkeulUseCaseProtocol {
        get { self[DeleteTikkeulUseCaseKey.self] }
        set { self[DeleteTikkeulUseCaseKey.self] = newValue }
    }
}



