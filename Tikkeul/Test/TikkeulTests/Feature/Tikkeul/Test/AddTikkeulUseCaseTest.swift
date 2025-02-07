//
//  AddTikkeulUseCaseTest.swift
//  TikkeulTests
//
//  Created by 정지훈 on 2/6/25.
//

import XCTest
@testable import Tikkeul

final class AddTikkeulUseCaseTest: XCTestCase {

    var sut: StubAddTikkeulUseCase!

    // MARK: - Test Cycle

    override func setUpWithError() throws {
        sut = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup

    private func setupSut() -> StubAddTikkeulUseCase {
        return StubAddTikkeulUseCase(
            repository: StubTikkeulRepository()
        )
    }
    
    // MARK: - Test Function

    func test_addTikkeul함수호출시_새로운티끌을전달했을때_마지막에추가되는지확인() throws {
        // Given
        let newItem = Tikkeul(id: "100", money: 10000, category: "Snack", date: Date())
        let initialCount = sut.repository.items.count
        
        // When
        try sut.addTikkeul(item: newItem)
        
        // Then
        XCTAssertEqual(sut.repository.items.count, initialCount + 1)
        XCTAssertEqual(sut.repository.items.last, newItem)
    }
}
