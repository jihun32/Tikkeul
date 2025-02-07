//
//  StubUpdateTikkeulUseCase.swift
//  TikkeulTests
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

final class StubUpdateTikkeulUseCase: UpdateTikkeulUseCase {
    func updateTikkeul(item: TikkeulData) -> [TikkeulData]? {
        var items = TikkeulData.items
        guard let updateIndex = items.firstIndex(where: { $0.id == item.id }) else { return nil }
        
        items[updateIndex] = item
        
        return items
    }
}
