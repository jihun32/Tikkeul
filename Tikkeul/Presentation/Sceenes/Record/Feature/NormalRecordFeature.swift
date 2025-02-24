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
    //첫String -> type + ago 두번째 스트링 -> mm-dd
    typealias TikkeulCache = [String: [String: [PresentiableTikkeulData]]]
    
    @ObservableState
    struct State {
        // UI State
        var currentDateUnit: RecordDateUnit = .weekly(ago: 0, data: [:])
        var cachedData: TikkeulCache = [:]
    }
    
    enum Action {
        // LifeCycle
        case onAppear
        
        // Data Management
        case fetchTikkeulList
        
        // User Action
        case dateUnitChanged(dateUnit: RecordDateUnit)
        case previousDate
        case nextDate
        
        // Update State
        case setTikkeulList(data: [String: [PresentiableTikkeulData]])
    }
    
    @Dependency(\.fetchTikkeulUseCase) var fetchTikkeulUseCase
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                // LifeCycle
            case .onAppear:
                return .send(.fetchTikkeulList)
                
                // User Action
            case let .dateUnitChanged(dateUnitType):
                switch dateUnitType {
                case .weekly:
                    state.currentDateUnit = .weekly(ago: 0, data: state.currentDateUnit.tikkeuls)
                case .monthly:
                    state.currentDateUnit = .monthly(ago: 0, data: state.currentDateUnit.tikkeuls)
                }
                return .send(.fetchTikkeulList)
                
            case .previousDate:
                state.currentDateUnit.ago -= 1
                let key = state.currentDateUnit.cacheKey
                if let cached = state.cachedData[key] {
                    state.currentDateUnit.tikkeuls = cached
                    return .none
                }
                return .send(.fetchTikkeulList)
                
            case .nextDate:
                state.currentDateUnit.ago += 1
                let key = state.currentDateUnit.cacheKey
                if let cached = state.cachedData[key] {
                    state.currentDateUnit.tikkeuls = cached
                    return .none
                }
                return .send(.fetchTikkeulList)
                
                // Data Management
            case .fetchTikkeulList:
                return .run { [currentDateUnit = state.currentDateUnit] send in
                    guard let range = getDateRange(currentDateUnit: currentDateUnit) else { return }
                    
                    let responseData = try fetchTikkeulUseCase.fetchTikkeul(from: range.lowerBound, to: range.upperBound)
                    
                    let groupedResponseData = Dictionary(grouping: responseData) { data in
                        data.date.formattedString(dateFormat: .mm_dd)
                    }
                    
                    let groupedPresentiableData = convertToPresentiableData(from: groupedResponseData)
                    
                    await send(.setTikkeulList(data: groupedPresentiableData))
                }
                
                // Update State
            case let .setTikkeulList(data):
                let key = state.currentDateUnit.cacheKey
                state.cachedData[key] = data
                state.currentDateUnit.tikkeuls = data
                return .none
            }
        }
    }
}

// MARK: - Helper Function
extension NormalRecordFeature {
    
    private func getDateRange(currentDateUnit: RecordDateUnit) -> Range<Date>? {
        switch currentDateUnit {
        case .weekly(let ago, _):
            return Date().getWeekRange(weeksAgo: ago)
        case .monthly(let ago, _):
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
