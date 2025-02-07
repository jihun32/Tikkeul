//
//  StubAddTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

final class StubAddTikkeulUseCase: AddTikkeulUseCase {
    let repository: StubTikkeulRepository
    
    init(repository: StubTikkeulRepository) {
        self.repository = repository
    }
    
    func addTikkeul(item: Tikkeul) throws {
        try repository.addTikkeul(item: item)
    }
}
