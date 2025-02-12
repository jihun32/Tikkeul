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
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
    
}


