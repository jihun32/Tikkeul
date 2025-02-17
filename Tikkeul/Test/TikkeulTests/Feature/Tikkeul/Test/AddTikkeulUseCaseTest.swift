//
//  AddTikkeulUseCaseTest.swift
//  TikkeulTests
//
//  Created by 정지훈 on 2/6/25.
//

import XCTest
@testable import Tikkeul

final class AddTikkeulUseCaseTest: XCTestCase {

    var sut: AddTikkeulUseCase!

    // MARK: - Test Cycle

    override func setUpWithError() throws {
        sut = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup

    private func setupSut() -> AddTikkeulUseCase {
        return AddTikkeulUseCase(
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
    }
    
    // MARK: - Test Function

    func test_addTikkeul함수호출시_새로운티끌을전달했을때_마지막에추가되는지확인() throws {
        // Given
        let newItem = TikkeulData(id: UUID(), money: 10000, category: "Snack", date: Date())
        let initialItems = TikkeulData.dummyData
        let stubRepository = TikkeulRepository(persistenceController: .testValue)
        
        // When
        try sut.addTikkeul(item: newItem)
        let date = Date()
        let resultItems = try stubRepository.fetchTikkeul(from: date.startOfDay, to: date.endOfDay)
        // Then
        XCTAssertEqual(resultItems.count, initialItems.count + 1)
        XCTAssertEqual(resultItems.last, newItem)
    }
}
