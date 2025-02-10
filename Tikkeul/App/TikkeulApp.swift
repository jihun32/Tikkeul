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
    
    let store: StoreOf<TikkeulAppFeature> = Store(
        initialState: TikkeulAppFeature.State(), {
            TikkeulAppFeature()
        })
    
    var body: some Scene {
        WindowGroup {
            TikkeulRootView()
        }
    }
}
