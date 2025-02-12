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
        var moneyText: String = ""
        var memoText: String = ""
    }
    
    enum Action {
        // User Action
        case moneyTextFieldDidChange(money: String)
        case memoTextFieldDidChange(memo: String)
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
            }
        }
    }
}


