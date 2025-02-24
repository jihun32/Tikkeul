//
//  FetchTikkeulUseCaseTest.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import XCTest
@testable import Tikkeul

final class FetchTikkeulUseCaseTest: XCTestCase {
    
    var sut: FetchTikkeulUseCase!
    
    // MARK: - Test Cycle
    
    override func setUpWithError() throws {
        sut = setupSut()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Setup
    
    private func setupSut() -> FetchTikkeulUseCase {
        return FetchTikkeulUseCase(
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
    }
    
    // MARK: - Test Function
    
    func test_fetchTikkeul_오늘의데이터를가져오는지() throws {
        // Given
        let date = Date()
        let startOfDay = date.startOfDay
        guard let endOfDay = date.endOfDay else {
            XCTFail("endOfDay 계산 실패")
            return
        }
        
        let expectedItems = getFilteredItemsByRange(by: startOfDay..<endOfDay, items: TikkeulData.dummyData)
        
        // When
        let resultItems = try sut.fetchTikkeul(from: startOfDay, to: endOfDay)
        
        // Then
        XCTAssertEqual(resultItems, expectedItems)
    }
    
    func test_fetchTikkeul_저번주데이터를가져오는지() throws {
        // Given
        guard let lastWeekRange = Date().getWeekRange(weeksAgo: -1) else {
            XCTFail("lastWeekRange 계산 실패")
            return
        }
        
        let expectedItems = getFilteredItemsByRange(by: lastWeekRange, items: TikkeulData.dummyData)

        // When
        let resultItems = try sut.fetchTikkeul(from: lastWeekRange.lowerBound, to: lastWeekRange.upperBound)

        // Then
        XCTAssertEqual(resultItems, expectedItems)
    }

    func test_fetchTikkeul_이번주데이터를가져오는지() throws {
        // Given
        guard let thisWeekRange = Date().getWeekRange(weeksAgo: 0) else {
            XCTFail("thisWeekRange 계산 실패")
            return
        }
        
        let expectedItems = getFilteredItemsByRange(by: thisWeekRange, items: TikkeulData.dummyData)

        // When
        let resultItems = try sut.fetchTikkeul(from: thisWeekRange.lowerBound, to: thisWeekRange.upperBound)

        // Then
        XCTAssertEqual(resultItems, expectedItems)
    }

    func test_fetchTikkeul_저번달데이터를가져오는지() throws {
        // Given
        guard let lastMonthRange = Date().getMonthRange(monthsAgo: -1) else {
            XCTFail("lastMonthRange 계산 실패")
            return
        }
        
        let expectedItems = getFilteredItemsByRange(by: lastMonthRange, items: TikkeulData.dummyData)

        // When
        let resultItems = try sut.fetchTikkeul(from: lastMonthRange.lowerBound, to: lastMonthRange.upperBound)

        // Then
        XCTAssertEqual(resultItems, expectedItems)
    }

    func test_fetchTikkeul_이번달데이터를가져오는지() throws {
        // Given
        guard let thisMonthRange = Date().getMonthRange(monthsAgo: 0) else {
            XCTFail("thisMonthRange 계산 실패")
            return
        }
        
        let expectedItems = getFilteredItemsByRange(by: thisMonthRange, items: TikkeulData.dummyData)

        // When
        let resultItems = try sut.fetchTikkeul(from: thisMonthRange.lowerBound, to: thisMonthRange.upperBound)

        // Then
        XCTAssertEqual(resultItems, expectedItems)
    }
    
    private func getFilteredItemsByRange(by range: Range<Date>, items: [TikkeulData]) -> [TikkeulData] {
        return items.filter { data in
            return data.date >= range.lowerBound && data.date < range.upperBound
        }.sorted { ($0.date) < ($1.date) }
    }
}
