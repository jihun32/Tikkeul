//
//  PersistenceDependency.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import CoreData
import ComposableArchitecture

extension PersistenceController {
    static let liveValue = PersistenceController.shared
    static let testValue: PersistenceController = {
        
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        
        var items = TikkeulData.dummyData
        
        items.forEach {
            let item = Tikkeul(context: context)
            item.id = $0.id
            item.money = Int32($0.money)
            item.category = $0.category
            item.memo = $0.memo
            item.date = $0.date
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
