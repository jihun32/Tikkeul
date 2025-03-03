//
//  MainTabFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/10/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct MainTabFeature {
    
    @ObservableState
    struct State {
        var selectedTab: TabDestination = .home
        var homeState: HomeFeature.State = .init()
        var recordState: RecordFeature.State = .init()
    }
    
    enum Action {
        case selectedTabChanged(TabDestination)
        case homeAction(HomeFeature.Action)
        case recordAction(RecordFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.homeState, action: \.homeAction) {
            HomeFeature()
        }
        Scope(state: \.recordState, action: \.recordAction) {
            RecordFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
                
            case .homeAction:
                return .none
                
            case .recordAction:
                return .none
            }
        }
    }
}
