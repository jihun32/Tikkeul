//
//  FetchTikkeulkUseCaseTest.swift
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
            repository: StubTikkeulRepository(
                persistenceController: .testValue
            )
        )
    }
    
    // MARK: - Test Function

    func test_fetchTikkeul함수호출시_Tikkeul데이터를받아오는지() throws {
        // Given
        let initialItems = TikkeulData.dummyData
        let date = Date()
        
        // When
        let resultItems = try sut.fetchTikkeul(from: date.startOfDay, to: date.endOfDay)
        
        // Then
        XCTAssertEqual(resultItems, initialItems)
    }
}
