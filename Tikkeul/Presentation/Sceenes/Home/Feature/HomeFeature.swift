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
        @Presents var saveTikkeul: SaveTikkeulFeature.State?
        
        // UI State
        var tikkeulList: [HomeTikkeulData] = HomeTikkeulData.data
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
        // Other Feature
        case saveTikkeul(PresentationAction<SaveTikkeulFeature.Action>)
        
        // User Action
        case addTikkeulButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addTikkeulButtonTapped:
                state.saveTikkeul = SaveTikkeulFeature.State()
                
                return .none
                
                // Other Feature Action
            case .saveTikkeul:
                return .none
            }
        }
        .ifLet(\.$saveTikkeul, action: \.saveTikkeul) {
            SaveTikkeulFeature()
        }
    }
    
}
