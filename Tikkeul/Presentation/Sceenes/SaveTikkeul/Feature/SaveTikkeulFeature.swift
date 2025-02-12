//
//  SaveTikkeulFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/10/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct SaveTikkeulFeature {
    
    @ObservableState
    struct State {
        // Present State
        @Presents var choiceCategory: ChoiceCategoryFeature.State?
        
        // UI State
        var moneyText: String = ""
        var memoText: String = ""
        var categoryText: String?
    }
    
    enum Action {
        
        // Present Action
        case choiceCategory(PresentationAction<ChoiceCategoryFeature.Action>)
        
        // User Action
        case moneyTextFieldDidChange(money: String)
        case memoTextFieldDidChange(memo: String)
        case categoryButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .moneyTextFieldDidChange(money):
                state.moneyText = money
                
                return .none
                
            case let .memoTextFieldDidChange(memo):
                state.memoText = memo
                
                return .none
                
            case .categoryButtonTapped:
                state.choiceCategory = ChoiceCategoryFeature.State()
                
                return .none
                
                
                // Other Feature Action
            case let .choiceCategory(.presented(.delegate(.choiceCategory(category)))):
                state.categoryText = category.emoji + category.title
                state.choiceCategory = nil
                
                return .none
                
            case .choiceCategory:
                return .none
            }
        }
        .ifLet(\.$choiceCategory, action: \.choiceCategory) {
            ChoiceCategoryFeature()
        }
    }
}


