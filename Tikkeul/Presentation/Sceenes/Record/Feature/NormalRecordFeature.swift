//
//  NormalRecordFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/24/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct NormalRecordFeature {
    
    @ObservableState
    struct State {
        // UI State
        var weeklyTikkeuls: [String: [PresentiableTikkeulData]] = [:]
        var monthlyTikkeuls: [String: [PresentiableTikkeulData]] = [:]
        var currentDateUnit: RecordDateUnit = .weekly
        var currentTikkeuls: [String: [PresentiableTikkeulData]] {
            switch currentDateUnit {
            case .weekly:
                return weeklyTikkeuls
            case .monthly:
                return monthlyTikkeuls
            }
        }
    }
    
    enum Action {
        // LifeCycle
        case onAppear
        
        // Data Management
        case fetchTikkeulList(ago: Int)
        
        // User Action
        case dateUnitChanged(dateUnit: RecordDateUnit)
        
        // Update State
        case setTikkeulList(items: [String: [PresentiableTikkeulData]])
    }
    
    @Dependency(\.fetchTikkeulUseCase) var fetchTikkeulUseCase
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                // LifeCycle
            case .onAppear:
                return .send(.fetchTikkeulList(ago: 0))
                
                // Data Management
            case let .fetchTikkeulList(ago):
                return .run { [currentDateUnit = state.currentDateUnit] send in
                    guard let range = getDateRange(currentDateUnit: currentDateUnit, ago: ago) else { return }
                    
                    let responseData = try fetchTikkeulUseCase.fetchTikkeul(from: range.lowerBound, to: range.upperBound)
                    
                    let groupedResponseData = Dictionary(grouping: responseData) { data in
                        data.date.formattedString(dateFormat: .mm_dd)
                    }
                    
                    let groupedPresentiableData = convertToPresentiableData(from: groupedResponseData)
                    
                    await send(.setTikkeulList(items: groupedPresentiableData))
                }
                
                // User Action
            case let .dateUnitChanged(dateUnit):
                state.currentDateUnit = dateUnit
                return .none
                
                // Update State
            case .setTikkeulList(let items):
                switch state.currentDateUnit {
                case .weekly:
                    state.weeklyTikkeuls = items
                case .monthly:
                    state.monthlyTikkeuls = items
                }
                return .none
            }
        }
    }
}

// MARK: - Helper Function
extension NormalRecordFeature {
    private func getDateRange(currentDateUnit: RecordDateUnit, ago: Int) -> Range<Date>? {
        switch currentDateUnit {
        case .weekly:
            return Date().getWeekRange(weeksAgo: ago)
        case .monthly:
            return Date().getMonthRange(monthsAgo: ago)
        }
    }
    
    private func convertToPresentiableData(from groupedData: [String: [TikkeulData]]) -> [String: [PresentiableTikkeulData]] {
        groupedData.mapValues { group in
            group.compactMap { data in
                guard let category = TikkeulCategory(rawValue: data.category) else { return nil }
                return PresentiableTikkeulData(
                    id: data.id,
                    money: data.money,
                    category: category,
                    time: data.date.formattedString(dateFormat: .timeAMorPM),
                    memo: data.memo
                )
            }
        }
    }
}

