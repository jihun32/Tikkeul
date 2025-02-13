//
//  UpdateTikkeulUseCase.swift
//  TikkeulTests
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

final class UpdateTikkeulUseCase: UpdateTikkeulUseCaseProtocol {
    
    private let repository: TikkeulRepositoryProtocol
    
    init(repository: TikkeulRepositoryProtocol) {
        self.repository = repository
    }

    func updateTikkeul(item: TikkeulData) throws {
        try repository.updateTikkeul(item: item)
    }
}
