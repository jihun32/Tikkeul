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
        var category: TikkeulCategory?
        var isEnableSaveButton: Bool = false
        var memoCountText: String = "0/10"
        
        // Delegate State
        var addableTikkeul: TikkeulData?
    }
    
    enum Action {
        
        // Present Action
        case choiceCategory(PresentationAction<ChoiceCategoryFeature.Action>)
        
        // User Action
        case moneyTextFieldDidChange(money: String)
        case memoTextFieldDidChange(memo: String)
        case categoryButtonTapped
        
        // Delegate
        case delegate(Delegate)
        enum Delegate {
            case saveButtonTapped
            case dismissButtonTapped
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
                // User Action
            case let .moneyTextFieldDidChange(money):
                state.moneyText = money
                state.isEnableSaveButton = !money.isEmpty && state.categoryText != nil
                return .none
                
            case let .memoTextFieldDidChange(memo):
                state.memoText = memo
                state.memoCountText = "\(state.memoText.count)/10"
                return .none
                
            case .categoryButtonTapped:
                state.choiceCategory = ChoiceCategoryFeature.State()
                
                return .none
                
                // Delegate
                
            case .delegate(.saveButtonTapped):
                guard let money = Int(state.moneyText.filter { $0.isNumber }),
                      let category = state.category?.rawValue
                else { return .none }
                state.addableTikkeul = TikkeulData(
                    id: UUID(),
                    money: money,
                    category: category,
                    date: Date(),
                    memo: state.memoText
                )
                return .none
                
            case .delegate:
                return .none
                
                
                // Other Feature Action
            case let .choiceCategory(.presented(.delegate(.choiceCategory(category)))):
                state.categoryText = category.emoji + category.title
                state.category = category
                state.choiceCategory = nil
                state.isEnableSaveButton = !state.moneyText.isEmpty && state.categoryText != nil
                
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


