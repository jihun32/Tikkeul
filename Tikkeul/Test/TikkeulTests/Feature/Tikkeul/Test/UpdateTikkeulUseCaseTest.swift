//
//  UpdateTikkeulUseCaseTest.swift
//  TikkeulTests
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

import XCTest
@testable import Tikkeul

final class UpdateTikkeulUseCaseTest: XCTestCase {
    
    var sut: UpdateTikkeulUseCase!
    
    // MARK: - Test Cycle
    
    override func setUpWithError() throws {
        sut = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup
    
    private func setupSut() -> UpdateTikkeulUseCase {
        return UpdateTikkeulUseCase(
            repository: StubTikkeulRepository()
        )
    }
    
    // MARK: - Test Function
    
    func test_updateTikkeul함수호출시_변경할아이템을전달할때_업데이트된아이템배열을반환하는지() throws {
        
        // Given
        let updateItem = TikkeulData(id: "1", money: 5000, category: "Snack", date: Date())
        var expectedResult = TikkeulData.dummyData
        expectedResult[0] = updateItem
        
        // When
        let resultItems = sut.updateTikkeul(item: updateItem, items: TikkeulData.dummyData)
        
        // Then
        XCTAssertEqual(resultItems, expectedResult)
    }
    
    func test_updateTikkeul함수호출시_존재하지않는Id아이템을전달할때_nil을반환하는지() throws {
        
        // Given
        let updateItem = TikkeulData(id: "100", money: 5000, category: "Snack", date: Date())
        
        // When
        let resultItems = sut.updateTikkeul(item: updateItem, items: TikkeulData.dummyData)
        
        // Then
        XCTAssertNil(resultItems)
    }
}
