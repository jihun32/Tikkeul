//
//  TikkeulAppFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/10/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct TikkeulAppFeature {
    
    @ObservableState
    struct State {
        var mainTabState: MainTabFeature.State?
    }
    
    enum Action {
        case mainTabAction(MainTabFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .mainTabAction:
                return .none
            }
        }
        .ifLet(\.mainTabState, action: \.mainTabAction) {
            MainTabFeature()
        }
    }
    
}


