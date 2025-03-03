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
        var dateRangeString: String = ""
        var totalMoney: Int {
            currentDateUnit.tikkeuls.values
                .flatMap { $0 }
                .reduce(0) { total, data in total + data.money }
        }
        var chartData: [(date: String, money: Int)] = []
        let weeklyLabels = ["1주차", "2주차", "3주차", "4주차", "5주차", "6주차"]
    }
    
    enum Action {
        // LifeCycle
        case onAppear
        
        // Data Management
        case fetchTikkeulList
        
        // User Action
        case dateUnitChanged(dateUnit: RecordDateUnit)
        case previousDateButtonTapped
        case nextDateButtonTapped
        
        // Update State
        case updateTikkeulList(data: [String: [PresentiableTikkeulData]])
        case updateDateRange(range: Range<Date>)
        case updateChartData(range: Range<Date>)
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
                
            case .previousDateButtonTapped:
                state.currentDateUnit.ago -= 1
                let key = state.currentDateUnit.cacheKey
                if let cached = state.cachedData[key] {
                    state.currentDateUnit.tikkeuls = cached
                    if let range = getDateRange(currentDateUnit: state.currentDateUnit) {
                        return .merge(
                            .send(.updateDateRange(range: range)),
                            .send(.updateChartData(range: range))
                        )
                    }
                    return .none
                }
                return .send(.fetchTikkeulList)
                
            case .nextDateButtonTapped:
                state.currentDateUnit.ago += 1
                let key = state.currentDateUnit.cacheKey
                if let cached = state.cachedData[key] {
                    state.currentDateUnit.tikkeuls = cached
                    if let range = getDateRange(currentDateUnit: state.currentDateUnit) {
                        return .merge(
                            .send(.updateDateRange(range: range)),
                            .send(.updateChartData(range: range))
                        )
                    }
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
                    
                    await send(.updateDateRange(range: range))
                    await send(.updateTikkeulList(data: groupedPresentiableData))
                    await send(.updateChartData(range: range))
                }
                
                // Update State
            case let .updateTikkeulList(data):
                let key = state.currentDateUnit.cacheKey
                state.cachedData[key] = data
                state.currentDateUnit.tikkeuls = data
                return .none
                
            case let .updateDateRange(range):
                var result = ""
                switch state.currentDateUnit {
                case .weekly:
                    result = "\(range.lowerBound.formattedString(dateFormat: .mm_dd)) ~ \(range.upperBound.formattedString(dateFormat: .mm_dd))"
                    
                case .monthly:
                    result =  range.lowerBound.formattedString(dateFormat: .m)
                }
                
                state.dateRangeString = result
                return .none
                
            case let .updateChartData(range):
                let allDates = stride(from: range.lowerBound, to: range.upperBound, by: 86400).map { $0 }
                
                let existingData = state.currentDateUnit.tikkeuls.mapValues { list in
                    list.reduce(0) { $0 + $1.money }
                }
                
                switch state.currentDateUnit {
                case .monthly:
                    updateMonthlyChartData(allDates: allDates, existingData: existingData, state: &state)
                case .weekly:
                    updateWeeklyChartData(allDates: allDates, existingData: existingData, state: &state)
                }
                
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
    
    private func formatDateRange(range: Range<Date>, unit: RecordDateUnit) -> String {
        switch unit {
        case .weekly:
            return "\(range.lowerBound.formattedString(dateFormat: .mm_dd)) ~ \(range.upperBound.formattedString(dateFormat: .mm_dd))"
        case .monthly:
            return range.lowerBound.formattedString(dateFormat: .m)
        }
    }
    
    private func updateMonthlyChartData(allDates: [Date], existingData: [String: Int], state: inout State) {
        let calendar = Calendar.current
        // 캘린더 기준 주 번호로 그룹화
        let weeklyGrouped = Dictionary(grouping: allDates) { date in
            calendar.component(.weekOfMonth, from: date)
        }
        
        // 각 그룹별 금액 합산
        let weeklyData = weeklyGrouped.map { (week, dates) -> (week: Int, money: Int) in
            let money = dates.reduce(0) { total, date in
                let dateStr = date.formattedString(dateFormat: .mm_dd)
                return total + (existingData[dateStr] ?? 0)
            }
            return (week, money)
        }
        
        // 주 번호 순으로 정렬 후, 미리 정의된 주차 레이블과 매핑 ("1주차", "2주차", …)
        let sortedWeeklyData = weeklyData.sorted { $0.week < $1.week }
        state.chartData = sortedWeeklyData.enumerated().map { (index, data) in
            (date: state.weeklyLabels[index], money: data.money)
        }
    }

    private func updateWeeklyChartData(allDates: [Date], existingData: [String: Int], state: inout State) {
        state.chartData = allDates.map { date in
            let dateStr = date.formattedString(dateFormat: .mm_dd)
            return (dateStr, existingData[dateStr] ?? 0)
        }
    }
}
