//
//  ChoiceCateogryFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/12/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct ChoiceCategoryFeature {
    
    @ObservableState
    struct State {
        let categories: [TikkeulCategory] = TikkeulCategory.allCases
    }
    
    enum Action {
        
        // User Action
        case categoryItemTapped(category: TikkeulCategory)
        case delegate(Delegate)
        
        // Delegate
        enum Delegate {
            case choiceCategory(category: TikkeulCategory)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
                // User Action
            case let .categoryItemTapped(category):
                return .send(.delegate(.choiceCategory(category: category)))
                
                // Delegate
            case .delegate:
                return .none
            }
        }
    }
    
}


