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
    
    var navigationTitle: String {
        switch self {
        case .home:
            return "오늘의 티끌"
        case .record:
            return "기록"
        case .settings:
            return "설정"
        }
    }
    
    var navigationTitleMode: NavigationBarItem.TitleDisplayMode {
        switch self {
        case .home:
            return .large
        case .record:
            return .inline
        case .settings:
            return .automatic
        }
    }
}

struct MainTabView: View {
    
    @Perception.Bindable var store: StoreOf<MainTabFeature>
    
    var body: some View {
        NavigationStack {
            TabView(selection: $store.selectedTab.sending(\.selectedTabChanged)) {
                
                HomeTikkeulView(store: store.scope(state: \.homeState, action: \.homeAction))
                    .tag(TabDestination.home)
                    .tabItem {
                        Label("홈", systemImage: "house")
                    }
                
                RecordRootView()
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
            .navigationTitle(store.selectedTab.navigationTitle)
            .navigationBarTitleDisplayMode(store.selectedTab.navigationTitleMode)
        }
    }
}

#Preview {
    MainTabView(store: Store(initialState: MainTabFeature.State(), reducer: {
        MainTabFeature()
    }))
}
