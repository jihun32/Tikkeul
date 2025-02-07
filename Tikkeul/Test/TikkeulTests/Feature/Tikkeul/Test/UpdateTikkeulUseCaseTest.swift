//
//  UpdateTikkeulUseCaseTest.swift
//  TikkeulTests
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

import XCTest

final class UpdateTikkeulUseCaseTest: XCTestCase {
    
    var sut: StubUpdateTikkeulUseCase!
    
    // MARK: - Test Cycle
    
    override func setUpWithError() throws {
        sut = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup
    
    private func setupSut() -> StubUpdateTikkeulUseCase {
        return StubUpdateTikkeulUseCase()
    }
    
    // MARK: - Test Function
    
    private func test_updateTikkeul함수호출시_변경할아이템을전달할때_업데이트된아이템배열을반환하는지() throws {
        
        // Given
        let updateItem = TikkeulData(id: "1", money: 5000, category: "Snack", date: Date())
        var expectedResult = TikkeulData.items
        expectedResult[0] = updateItem
        
        // When
        let resultItems = sut.updateTikkeul(item: updateItem)
        
        // Then
        XCTAssertEqual(resultItems, expectedResult)
    }
    
    private func test_updateTikkeul함수호출시_존재하지않는Id아이템을전달할때_nil을반환하는지() throws {
        
        // Given
        let updateItem = TikkeulData(id: "100", money: 5000, category: "Snack", date: Date())
        
        // When
        let resultItems = sut.updateTikkeul(item: updateItem)
        
        // Then
        XCTAssertNil(resultItems)
    }
}
