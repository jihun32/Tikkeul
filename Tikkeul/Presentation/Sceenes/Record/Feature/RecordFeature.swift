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
        
        // UI State
        var selectedTab: RecordTab = .normal
        
        // Other Feature
        var normalRecord: NormalRecordFeature.State = .init()
        var categoryRecord: CategoryRecordFeature.State = .init()
    }
    
    enum Action {
        
        // User Action
        case topTabBarChanged(selectedTab: RecordTab)
        
        // Other Feature
        case normalRecord(NormalRecordFeature.Action)
        case categoryRecord(CategoryRecordFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.normalRecord, action: \.normalRecord) {
            NormalRecordFeature()
        }
        
        Scope(state: \.categoryRecord, action: \.categoryRecord) {
            CategoryRecordFeature()
        }
        
        Reduce { state, action in
            switch action {
                
                // User Action
            case let .topTabBarChanged(tab):
                state.selectedTab = tab
                
                return .none
                
                // Other Feature
            case .normalRecord:
                return .none
                
            case .categoryRecord:
                return .none
            }
        }
    }
    
}


