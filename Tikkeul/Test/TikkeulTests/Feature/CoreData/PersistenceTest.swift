//
//  PersistenceTests.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import XCTest
import CoreData

@testable import Tikkeul

final class PersistenceTests: XCTestCase {
    
    var sut: PersistenceController!
    var context: NSManagedObjectContext!
    
    // MARK: - Test Cycle
    
    override func setUpWithError() throws {
        (sut, context) = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup
    
    private func setupSut() -> (PersistenceController, NSManagedObjectContext) {
        let persistenceController = PersistenceController(inMemory: true)
        return (persistenceController, persistenceController.container.viewContext)
    }
    
    func test_Create_Item() {
        // 새로운 Tikkeul 객체 생성
        let newItem = Tikkeul(context: context)
        newItem.id = UUID()
        newItem.money = 5000
        newItem.category = "TestCategory"
        newItem.memo = "새로 생성한 아이템"
        newItem.date = Date()
        
        // 저장 시도
        do {
            try context.save()
        } catch {
            XCTFail("아이템 저장 실패: \(error)")
        }
        
        // 생성한 객체가 실제로 저장되었는지 조회
        let fetchRequest: NSFetchRequest<Tikkeul> = Tikkeul.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", newItem.id! as CVarArg)
        do {
            let results = try context.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1, "새로 생성한 아이템이 조회되지 않음")
        } catch {
            XCTFail("아이템 조회 실패: \(error)")
        }
    }
    
    // MARK: - Read
    func testReadItems() {
        // 미리 4개의 아이템을 저장해두는 경우 (PersistenceDependency.swift의 testValue처럼)
        // 또는 아래와 같이 테스트를 위한 데이터를 직접 생성할 수 있습니다.
        // 여기서는 간단하게 2개의 아이템을 생성 후 조회합니다.
        for i in 1...2 {
            let item = Tikkeul(context: context)
            item.id = UUID()
            item.money = Int32(1000 * i)
            item.category = "Category\(i)"
            item.memo = "Memo \(i)"
            item.date = Date()
        }
        do {
            try context.save()
        } catch {
            XCTFail("미리 생성한 아이템 저장 실패: \(error)")
        }
        
        // 전체 아이템 조회
        let fetchRequest: NSFetchRequest<Tikkeul> = Tikkeul.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            XCTAssertGreaterThanOrEqual(items.count, 2, "아이템이 충분히 생성되지 않음")
        } catch {
            XCTFail("아이템 조회 실패: \(error)")
        }
    }
    
    // MARK: - Update
    func testUpdateItem() {
        // 우선 테스트용 아이템 생성
        let item = Tikkeul(context: context)
        item.id = UUID()
        item.money = 3000
        item.category = "OriginalCategory"
        item.memo = "Original Memo"
        item.date = Date()
        
        do {
            try context.save()
        } catch {
            XCTFail("아이템 생성 실패: \(error)")
        }
        
        // 생성한 아이템의 memo 값을 업데이트
        let originalMemo = item.memo
        item.memo = "업데이트된 Memo"
        
        do {
            try context.save()
        } catch {
            XCTFail("업데이트 저장 실패: \(error)")
        }
        
        // 업데이트가 반영되었는지 확인
        let fetchRequest: NSFetchRequest<Tikkeul> = Tikkeul.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id! as CVarArg)
        do {
            let results = try context.fetch(fetchRequest)
            guard let updatedItem = results.first else {
                XCTFail("업데이트된 아이템 조회 실패")
                return
            }
            XCTAssertNotEqual(originalMemo, updatedItem.memo, "memo 값이 업데이트되지 않음")
            XCTAssertEqual(updatedItem.memo, "업데이트된 Memo", "memo 업데이트 값이 올바르지 않음")
        } catch {
            XCTFail("업데이트된 아이템 조회 실패: \(error)")
        }
    }
    
    // MARK: - Delete
    func testDeleteItem() {
        // 삭제할 아이템 생성
        let itemToDelete = Tikkeul(context: context)
        itemToDelete.id = UUID()
        itemToDelete.money = 7000
        itemToDelete.category = "DeleteCategory"
        itemToDelete.memo = "삭제될 아이템"
        itemToDelete.date = Date()
        
        do {
            try context.save()
        } catch {
            XCTFail("삭제 전 아이템 저장 실패: \(error)")
        }
        
        // 아이템 삭제
        context.delete(itemToDelete)
        do {
            try context.save()
        } catch {
            XCTFail("삭제 후 저장 실패: \(error)")
        }
        
        // 삭제가 반영되었는지 확인
        let fetchRequest: NSFetchRequest<Tikkeul> = Tikkeul.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", itemToDelete.id! as CVarArg)
        do {
            let results = try context.fetch(fetchRequest)
            XCTAssertEqual(results.count, 0, "아이템이 삭제되지 않음")
        } catch {
            XCTFail("삭제 후 아이템 조회 실패: \(error)")
        }
    }
}
