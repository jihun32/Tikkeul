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
        let stubRepository = TikkeulRepository(persistenceController: .testValue)
        
        let today = Date()
        guard let endOfDay = today.endOfDay else {
            XCTFail("날짜 계산 실패")
            return
        }
        
        let initialItemsToday = TikkeulData.dummyData.filter { item in
            return item.date >= today.startOfDay && item.date <= endOfDay
        }
        
        // When
        try sut.addTikkeul(item: newItem)
        
        let resultItems = try stubRepository.fetchTikkeul(from: today.startOfDay, to: endOfDay)
        // Then
        XCTAssertEqual(resultItems.count, initialItemsToday.count + 1)
        XCTAssertEqual(resultItems.last, newItem)
    }
}
