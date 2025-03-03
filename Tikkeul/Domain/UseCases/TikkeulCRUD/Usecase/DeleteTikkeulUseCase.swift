//
//  DeleteTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

final class DeleteTikkeulUseCase: DeleteTikkeulUseCaseProtocol {
    
    private let repository: TikkeulRepositoryProtocol
    
    init(repository: TikkeulRepositoryProtocol) {
        self.repository = repository
    }
    
    func deleteTikkeul(id: UUID) throws {
        try repository.deleteTikkeul(id: id)
    }
}
