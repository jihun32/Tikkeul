//
//  TikkeulApp.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/3/25.
//

import SwiftUI

import ComposableArchitecture

@main
struct TikkeulApp: App {
    
    private let store: StoreOf<TikkeulAppFeature> = Store(
        initialState: TikkeulAppFeature.State(), reducer: {
            TikkeulAppFeature()
        })
    
    var body: some Scene {
        WindowGroup {
            if let tabViewStore = store.scope(state: \.mainTabState, action: \.mainTabAction) {
                MainTabView(store: tabViewStore)
            }
        }
        
    }
}
