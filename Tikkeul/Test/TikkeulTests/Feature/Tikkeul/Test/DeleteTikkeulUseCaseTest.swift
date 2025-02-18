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
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
    }
    
    // MARK: - Test Function
    
    func test_deleteTikkeul함수호출시_삭제하고자하는아이템을전달했을때_삭제되고난후데이터를반환하는지() throws {
        
        // Given
        let deleteItemID = TikkeulData.dummyData[0].id
        
        // When
        try sut.deleteTikkeul(id: deleteItemID)
        
        // Then
        let stubRepository = TikkeulRepository(persistenceController: .testValue)
        let date = Date()
        let deletedItems = try stubRepository.fetchTikkeul(from: date.startOfDay, to: date.endOfDay)
        XCTAssertFalse(deletedItems.contains(where: { $0.id == deleteItemID }))
    }
    
    func test_deleteTikkeul함수호출시_삭제하고자하는아이템이없을시_nil을반환하는지() throws {
        
        // Given
        let deleteItemID = UUID()
        
        // When & Then
        XCTAssertThrowsError(try sut.deleteTikkeul(id: deleteItemID)) { error in
            guard let resultError = error as? RepositoryError else {
                XCTFail("예상하지 않은 에러 타입: \(error)")
                return
            }
            XCTAssertEqual(resultError, RepositoryError.itemNotFound)
        }
    }
}
