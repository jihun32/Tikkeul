//
//  StubTikkeulRepository.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

final class StubTikkeulRepository: TikkeulRepository {
    
    var items: [Tikkeul] = [
        Tikkeul(id: "1", money: 1000, category: "shopping", date: Date()),
        Tikkeul(id: "2", money: 2000, category: "shopping", date: Date()),
        Tikkeul(id: "3", money: 3000, category: "shopping", date: Date())
    ]
    
    func addTikkeul(item: Tikkeul) throws {
        items.append(item)
    }
    
    func deleteTikkeul(item: Tikkeul) throws {
        guard let deleteIndex = items.firstIndex(where: { item.id == $0.id }) else { return }
        items.remove(at: deleteIndex)
    }
    
    func updateTikkeul(item: Tikkeul) throws {
        
    }
    
    func fetchTikkeul(item: Tikkeul) throws -> [Tikkeul] {
        return []
    }
}



