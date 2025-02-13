//
//  PersistenceDependency.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import CoreData
import ComposableArchitecture

extension PersistenceController: DependencyKey {
    static let liveValue = PersistenceController.shared
    static let testValue: PersistenceController = {
        
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        
        let items = [
            HomeTikkeulData(id: UUID(), money: 1000, category: .beauty, time: "01:00 PM"),
            HomeTikkeulData(id: UUID(), money: 1000, category: .coffee, time: "02:00 PM"),
            HomeTikkeulData(id: UUID(), money: 1000, category: .delivery, time: "03:00 PM", memo: "test"),
            HomeTikkeulData(id: UUID(), money: 1000, category: .drink, time: "04:00 PM")
        ]
        
        items.forEach {
            let item = Tikkeul(context: context)
            item.id = $0.id
            item.money = Int16($0.money)
            item.category = $0.category.title
            item.memo = $0.memo
            item.date = Date()
        }
        // 데이터 저장
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()
    
}

extension DependencyValues {
    var persistenceController: PersistenceController {
        get { self[PersistenceController.self] }
        set { self[PersistenceController.self] = newValue }
    }
}
