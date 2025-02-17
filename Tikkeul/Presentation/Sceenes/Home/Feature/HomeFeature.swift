//
//  HomeFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/10/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct HomeFeature {
    
    @ObservableState
    struct State {
        // Present
        var path = StackState<SaveTikkeulFeature.State>()
        
        // UI State
        var tikkeulList: [HomeTikkeulData] = []
        var isEmptyTikkeulList: Bool {
            tikkeulList.isEmpty
        }
        var totalTikkeul: Int {
            tikkeulList
                .map { $0.money }
                .reduce(0, +)
        }
    }
    
    enum Action {
        // LifeCycle
        case onAppear
        
        // User Action
        case addTikkeulButtonTapped
        
        // Fetch Data
        case fetchTikkeulList
        case addTikkeulList(item: TikkeulData)
        case updateTikkeulList(item: TikkeulData)
        
        // Update State
        case setTikkeulList(items: [HomeTikkeulData])
        
        // Present
        case path(StackAction<SaveTikkeulFeature.State, SaveTikkeulFeature.Action>)
            
    }
    
    @Dependency(\.fetchTikkeulUseCase) var fetchTikkeulUseCase
    @Dependency(\.addTikkeulUseCase) var addTikkeulUseCase
    @Dependency(\.updateTikkeulUseCase) var updateTikkeulUseCase
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                // LifeCycle
            case .onAppear:
                return .send(.fetchTikkeulList)
                
                // Fetch Data
            case .fetchTikkeulList:
                return fetchTikkeulListEffect()
                
            case let .updateTikkeulList(item):
                return .run { send in
                    try updateTikkeulUseCase.updateTikkeul(item: item)
                    await send(.fetchTikkeulList)
                }
            case let .addTikkeulList(item):
                return .run { send in
                    try addTikkeulUseCase.addTikkeul(item: item)
                    await send(.fetchTikkeulList)
                }
                // Update State:
            case let.setTikkeulList(items):
                state.tikkeulList = items
                return .none
                
                // User Action
            case .addTikkeulButtonTapped:
                state.path.append(SaveTikkeulFeature.State())
                return .none
                
                // Other Feature Action
            case .path(.element(id: _, action: .delegate(.saveButtonTapped))):
                
                guard let saveState = state.path.last,
                      let tikkeul = saveState.addableTikkeul else { return .none }
                
                state.path.removeLast()
                
                if saveState.isEdit {
                    return .send(.updateTikkeulList(item: tikkeul))
                } else {
                    return .send(.addTikkeulList(item: tikkeul))
                }
                
            case .path(.element(id: _, action: .delegate(.backButtonTapped))):
                
                state.path.removeLast()
                return .none
                
            case .path:
                return .none
                
            }
        }
        .forEach(\.path, action: \.path) {
            SaveTikkeulFeature()
        }
    }
}


extension HomeFeature {
    private func fetchTikkeulListEffect() -> Effect<Action> {
        return .run { send in
            let date = Date()
            let responseData = try fetchTikkeulUseCase.fetchTikkeul(from: date.startOfDay, to: date.endOfDay)
            
            let tikkeulList: [HomeTikkeulData] = responseData.compactMap { data in
                guard let category = TikkeulCategory(rawValue: data.category) else { return nil }
                
                return HomeTikkeulData(
                    id: data.id,
                    money: data.money,
                    category: category,
                    time: data.date.formattedString(dateFormat: .timeAMorPM),
                    memo: data.memo
                )
            }
            await send(.setTikkeulList(items: tikkeulList))
        }
    }
}
