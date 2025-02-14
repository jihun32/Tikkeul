//
//  DeleteTikkeulUseCaseTest.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import XCTest
@testable import Tikkeul

final class DeleteTikkeulUseCaseTest: XCTestCase {
    
    var sut: DeleteTikkeulUseCase!
    
    // MARK: - Test Cycle
    
    override func setUpWithError() throws {
        sut = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup
    
    private func setupSut() -> DeleteTikkeulUseCase {
        return DeleteTikkeulUseCase(
            repository: StubTikkeulRepository(
                persistenceController: .testValue
            )
        )
    }
    
    // MARK: - Test Function
    
    func test_deleteTikkeul함수호출시_삭제하고자하는아이템을전달했을때_삭제되고난후데이터를반환하는지() throws {
        
        // Given
        let deleteItem = TikkeulData.dummyData[0]
        
        // When
        try sut.deleteTikkeul(item: deleteItem)
        
        // Then
        let stubRepository = StubTikkeulRepository(persistenceController: .testValue)
        let date = Date()
        let deletedItems = try stubRepository.fetchTikkeul(from: date.startOfDay, to: date.endOfDay)
        XCTAssertFalse(deletedItems.contains(deleteItem))
    }
    
    func test_deleteTikkeul함수호출시_삭제하고자하는아이템이없을시_nil을반환하는지() throws {
        
        // Given
        let deleteItem = TikkeulData(id: UUID(), money: 1000, category: "shopping", date: Date())
        
        // When & Then
        XCTAssertThrowsError(try sut.deleteTikkeul(item: deleteItem)) { error in
            guard let resultError = error as? RepositoryError else {
                XCTFail("예상하지 않은 에러 타입: \(error)")
                return
            }
            XCTAssertEqual(resultError, RepositoryError.itemNotFound)
        }
    }
}
