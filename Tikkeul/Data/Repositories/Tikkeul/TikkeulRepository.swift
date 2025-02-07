//
//  TikkeulRepository.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

// MARK: - Stub

final class StubTikkeulRepository: TikkeulRepositoryProtocol {
    func addTikkeul(item: TikkeulData, items: [TikkeulData]) -> [TikkeulData] {
        var newItems = items
        newItems.append(item)
        return newItems
    }
    
    func deleteTikkeul(item: TikkeulData, items: [TikkeulData]) -> [TikkeulData]? {
        var newItems = items
        guard let index = newItems.firstIndex(where: { $0.id == item.id }) else { return nil }
        
        newItems.remove(at: index)
        return newItems
    }

    func updateTikkeul(item: TikkeulData, items: [TikkeulData]) -> [TikkeulData]? {
        var newItems = items
        guard let index = newItems.firstIndex(where: { $0.id == item.id }) else { return nil }
        
        newItems[index] = item
        return newItems
    }
    
    func fetchTikkeul() -> [TikkeulData] {
        return TikkeulData.dummyData
    }
}
