//
//  TikkeulRepository.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import CoreData

// MARK: - Stub
final class StubTikkeulRepository: TikkeulRepositoryProtocol {
    
    private let persistenceController: PersistenceController
    private let context: NSManagedObjectContext
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        self.context = persistenceController.container.viewContext
    }
    
    func addTikkeul(item: TikkeulData) throws {
        let newItem = toContextItem(item: item, context: context)
        try context.save()
    }
    
    func deleteTikkeul(item: TikkeulData) throws {
        let fetchRequest: NSFetchRequest<Tikkeul> = Tikkeul.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        
        guard let objectToDelete = try context.fetch(fetchRequest).first else {
            throw RepositoryError.itemNotFound
        }
        
        context.delete(objectToDelete)
        try context.save()
    }
    
    func updateTikkeul(item: TikkeulData) throws {
        let fetchRequest: NSFetchRequest<Tikkeul> = Tikkeul.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        guard let objectToUpdate = try context.fetch(fetchRequest).first else {
            throw RepositoryError.itemNotFound
        }
        
        objectToUpdate.money = Int32(item.money)
        objectToUpdate.category = item.category
        objectToUpdate.date = item.date
        objectToUpdate.memo = item.memo
        
        try context.save()
    }
    
    func fetchTikkeul(from startDate: Date, to endDate: Date) throws -> [TikkeulData] {
        let fetchRequest: NSFetchRequest<Tikkeul> = Tikkeul.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let fetchedDatas = try context.fetch(fetchRequest)
        return try fetchedDatas.map { model in
            guard let id = model.id,
                  let category = model.category,
                  let date = model.date else {
                throw RepositoryError.missingRequiredProperty
            }
            
            return TikkeulData(
                id: id,
                money: Int(model.money),
                category: category,
                date: date,
                memo: model.memo
            )
        }
    }
}
