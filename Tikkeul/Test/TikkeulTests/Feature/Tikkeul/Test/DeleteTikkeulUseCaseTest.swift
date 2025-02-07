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
    
    private func test_deleteTikkeul함수호출시_삭제하고자하는아이템을전달했을때_삭제가올바르게이루어지는지() throws {
        
        // Given
        let deleteItem = TikkeulData(id: "1", money: 1000, category: "shopping", date: Date())
        
        // When
        let resultItems = sut.deleteTikkeul(item: deleteItem)
        
        // Then
        XCTAssertFalse(resultItems.contains(deleteItem))
    }
}
