//
//  DeleteTikkeulUseCaseTest.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import XCTest

final class DeleteTikkeulUseCaseTest: XCTestCase {
    
    var sut: StubDeleteTikkeulUseCase!
    
    // MARK: - Test Cycle
    
    override func setUpWithError() throws {
        sut = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup
    
    private func setupSut() -> StubDeleteTikkeulUseCase {
        return StubDeleteTikkeulUseCase()
    }
    
    // MARK: - Test Function
    
    private func test_deleteTikkeul함수호출시_삭제하고자하는아이템을전달했을때_삭제되고난후데이터를반환하는지() throws {
        
        // Given
        let deleteItem = TikkeulData(id: "1", money: 1000, category: "shopping", date: Date())
        
        // When
        let resultItems = sut.deleteTikkeul(item: deleteItem)
        
        // Then
        XCTAssertNotNil(resultItems)
        guard let items = resultItems else {
               XCTFail("resultItems은 nil이어선 안 됩니다.")
               return
           }
        XCTAssertFalse(items.contains(deleteItem))
    }
    
    private func test_deleteTikkeul함수호출시_삭제하고자하는아이템이없을시_nil을반환하는지() throws {
        
        // Given
        let deleteItem = TikkeulData(id: "10", money: 1000, category: "shopping", date: Date())
        
        // When
        let resultItems = sut.deleteTikkeul(item: deleteItem)
        
        // Then
        XCTAssertNil(resultItems)
    }
}
