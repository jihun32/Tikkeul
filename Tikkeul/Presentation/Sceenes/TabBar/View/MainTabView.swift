//
//  MainTabView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/3/25.
//

import SwiftUI

import ComposableArchitecture

enum TabDestination {
    case home
    case record
    case settings
}

struct MainTabView: View {
    
    @Perception.Bindable var store: StoreOf<MainTabFeature>
    
    var body: some View {
        TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
            
            HomeTikkeulView(store: store.scope(state: \.homeState, action: \.homeAction))
                .tag(TabDestination.home)
                .tabItem {
                    Label("홈", systemImage: "house")
                }
            
            Text("Record")
                .tag(TabDestination.record)
                .tabItem {
                    Label("기록", systemImage: "chart.bar.xaxis.ascending")
                }
            
            Text("settings")
                .tag(TabDestination.settings)
                .tabItem {
                    Label("설정", systemImage: "gearshape")
                }
               
        }
        .tint(.black)
    }
}

#Preview {
    MainTabView(store: Store(initialState: MainTabFeature.State(), reducer: {
        MainTabFeature()
    }))
}
