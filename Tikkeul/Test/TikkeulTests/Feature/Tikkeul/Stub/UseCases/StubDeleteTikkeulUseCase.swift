//
//  StubDeleteTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

final class StubDeleteTikkeulUseCase: DeleteTikkeulUseCase {
    func deleteTikkeul(item: TikkeulData) -> [TikkeulData]? {
        var items = TikkeulData.items
        guard let deleteIndex = items.firstIndex(where: { $0.id == item.id }) else { return nil }
        
        items.remove(at: deleteIndex)
        
        return items
    }
}
