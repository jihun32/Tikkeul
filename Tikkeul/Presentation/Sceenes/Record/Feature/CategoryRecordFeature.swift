//
//  CategoryRecordFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/25/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CategoryRecordFeature {
    
    @ObservableState
    struct State {
        var categoryData: [CategoryRecordData]?
        var rangeAgo: Int = 0
        var monthString: String = ""
    }
    
    @Dependency(\.fetchTikkeulUseCase) var fetchTikkeulUseCase
    
    enum Action {
        case onAppear
        
        case fetchTikkeuls
        
        case previousButtonTapped
        case nextButtonTapped
        
        case updateCategoryData(data: [TikkeulData])
        case updateMonthString(monthRange: Range<Date>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchTikkeuls)
            case .fetchTikkeuls:
                return .run { [ago = state.rangeAgo] send in
                    
                    guard let range = Date().getMonthRange(monthsAgo: ago) else { return }
                    let responseData = try fetchTikkeulUseCase.fetchTikkeul(from: range.lowerBound, to: range.upperBound)
                    
                    await send(.updateMonthString(monthRange: range))
                    await send(.updateCategoryData(data: responseData))
                }
            case let .updateCategoryData(data):
                let totalMoney = data.reduce(0.0) { $0 + Double($1.money) }
                
                let groupedData = Dictionary(grouping: data) { $0.category }
                
                // 그룹별로 합산 및 퍼센트 계산
                state.categoryData = groupedData.compactMap { (categoryKey, items) -> CategoryRecordData? in
                    guard let category = TikkeulCategory(rawValue: categoryKey) else { return nil }
                    let sumMoney = items.reduce(0.0) { $0 + Double($1.money) }
                    let percentage = totalMoney > 0 ? (sumMoney / totalMoney) * 100 : 0.0
                    
                    return CategoryRecordData(
                        category: category,
                        value: Int(percentage),
                        money: Int(sumMoney)
                    )
                }
                .sorted(by: { $0.money > $1.money })
                return .none
                
            case let .updateMonthString(monthRange):
                state.monthString = monthRange.lowerBound.formattedString(dateFormat: .m)
                return .none
                
            case .previousButtonTapped:
                state.rangeAgo -= 1
                
                return .send(.fetchTikkeuls)
            case .nextButtonTapped:
                state.rangeAgo += 1
                return .send(.fetchTikkeuls)
            }
        }
    }
    
}


