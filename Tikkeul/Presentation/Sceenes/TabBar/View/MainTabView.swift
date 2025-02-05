//
//  MainTabView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/3/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ForEach(TabDestination.allCases, id: \.title) { destination in
                tabView(destination)
                    .tabItem {
                        Label(
                            destination.title,
                            systemImage: destination.systemImageName
                        )
                    }
            }
        }
        .tint(.black)
    }
    
    // TODO: - 탭 별 뷰 만들기
    @ViewBuilder
    private func tabView(_ destination: TabDestination) -> some View {
        switch destination {
        case .home:
            HomeRootView()
        case .record:
            Text("record")
        case .settings:
            Text("settings")
        }
    }
}

#Preview {
    MainTabView()
}
