//
//  FetchTikkeulProtocol.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import Foundation

final class FetchTikkeulUseCase: FetchTikkeulUseCaseProtocol {
    
    private let repository: TikkeulRepositoryProtocol
    
    init(repository: TikkeulRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchTikkeul() throws -> [TikkeulData] {
        try repository.fetchTikkeul()
    }
}
