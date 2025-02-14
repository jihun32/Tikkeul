//
//  DependencyFetchTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/14/25.
//

import Foundation

import ComposableArchitecture

private enum FetchTikkeulUseCaseKey: DependencyKey {
    static let liveValue: FetchTikkeulUseCaseProtocol = FetchTikkeulUseCase(
        repository: StubTikkeulRepository(
            persistenceController: .liveValue
        )
    )
    
    static let testValue: FetchTikkeulUseCaseProtocol = FetchTikkeulUseCase(
        repository: StubTikkeulRepository(
            persistenceController: .testValue
        )
    )
}


extension DependencyValues {
    var fetchTikkeulUseCase: FetchTikkeulUseCaseProtocol {
        get { self[FetchTikkeulUseCaseKey.self] }
        set { self[FetchTikkeulUseCaseKey.self] = newValue }
    }
}
