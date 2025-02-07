//
//  StubDeleteTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

final class StubDeleteTikkeulUseCase: DeleteTikkeulUseCase {
    let repository: StubTikkeulRepository
    
    init(repository: StubTikkeulRepository) {
        self.repository = repository
    }
    
    func deleteTikkeul(item: Tikkeul) throws {
        try repository.deleteTikkeul(item: item)
    }
}
