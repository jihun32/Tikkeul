//
//  RecordFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/24/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct RecordFeature {
    
    @ObservableState
    struct State {
        var normalRecord: NormalRecordFeature.State = .init()
        
        var selectedTab: RecordTab = .normal
    }
    
    enum Action {
        case normalRecord(NormalRecordFeature.Action)
        case topTabBarChanged(selectedTab: RecordTab)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.normalRecord, action: \.normalRecord) {
            NormalRecordFeature()
        }
        
        Reduce { state, action in
            switch action {
                
            case let .topTabBarChanged(tab):
                state.selectedTab = tab
                
                return .none
                
            case .normalRecord:
                return .none
            }
        }
    }
    
}


