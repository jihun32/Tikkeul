//
//  TikkeulRepositoryProtocol.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import CoreData

protocol TikkeulRepositoryProtocol {
    func addTikkeul(item: TikkeulData) throws
    func deleteTikkeul(item: TikkeulData) throws
    func updateTikkeul(item: TikkeulData) throws
    func fetchTikkeul() throws -> [TikkeulData] 
}

extension TikkeulRepositoryProtocol {
    func toContextItem(item: TikkeulData, context: NSManagedObjectContext) -> Tikkeul {
        let newItem = Tikkeul(context: context)
        newItem.id = item.id
        newItem.money = Int16(item.money)
        newItem.category = item.category
        newItem.memo = item.memo
        newItem.date = item.date
        
        return newItem
    }
}
