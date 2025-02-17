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
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
    }
    
    // MARK: - Test Function
    
    func test_updateTikkeul함수호출시_변경할아이템을전달할때_업데이트된아이템배열을반환하는지() throws {
        
        // Given
        let stubRepository = TikkeulRepository(persistenceController: .testValue)
        let date = Date()
        var fetchedItems = try stubRepository.fetchTikkeul(from: date.startOfDay, to: date.endOfDay)
        
        // When
        fetchedItems[0].money = 100000
        try sut.updateTikkeul(item: fetchedItems[0])
        
        // Then
        let resultItems = try stubRepository.fetchTikkeul(from: date.startOfDay, to: date.endOfDay)
        XCTAssertEqual(resultItems, fetchedItems)
    }
    
    func test_updateTikkeul함수호출시_존재하지않는Id아이템을전달할때_itemNotFound에러를반환하는지() throws {
        
        // Given
        let updateItem = TikkeulData(id: UUID(), money: 5000, category: "Snack", date: Date())
        
        // When & Then
        XCTAssertThrowsError(try sut.updateTikkeul(item: updateItem)) { error in
            guard let repositoryError = error as? RepositoryError else {
                XCTFail("예상하지 않은 에러 타입: \(error)")
                return
            }
            XCTAssertEqual(repositoryError, RepositoryError.itemNotFound)
        }
    }
}
