//
//  AddTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

final class AddTikkeulUseCase: AddTikkeulUseCaseProtocol {
    
    private let repository: TikkeulRepositoryProtocol
    
    init(repository: TikkeulRepositoryProtocol) {
        self.repository = repository
    }
    
    func addTikkeul(item: TikkeulData) throws {
        try repository.addTikkeul(item: item)
    }
}
