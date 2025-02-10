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
//        var recordState: RecordFeature.State = .init()
//        var settingsState: SettingsFeature.State = .init()
    }
    
    enum Action {
        case selectedTabChanged(TabDestination)
        case homeAction(HomeFeature.Action)
//        case recordAction(RecordFeature.Action)
//        case settingsAction(SettingsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.homeState, action: \.homeAction) {
            HomeFeature()
        }
//        Scope(state: \.record, action: /Action.record) {
//            RecordFeature()
//        }
//        Scope(state: \.settings, action: /Action.settings) {
//            SettingsFeature()
//        }
        
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
                
            case .homeAction:
                return .none
            }
        }
    }
}
