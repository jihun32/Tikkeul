//
//  RecordRootView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import SwiftUI

import ComposableArchitecture

struct RecordView: View {
    
    @Perception.Bindable var store: StoreOf<RecordFeature>

    var body: some View {
        VStack(spacing: 0) {
            
            Text("기록")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            
            RecordTobTabBar(selectedTab: store.selectedTab) { tab in
                store.send(.topTabBarChanged(selectedTab: tab))
            }
            .padding(.top, 20)
            
            switch store.selectedTab {
            case .normal:
                NormalRecordView(
                    store: store.scope(
                        state: \.normalRecord,
                        action: \.normalRecord
                    )
                )
                
            case .category:
                Text("카테고리")
            }
            
            Spacer()
        }
        .background(Color.background)
    }
}

#Preview {
    RecordView(store: Store(initialState: RecordFeature.State(), reducer: {
        RecordFeature()
    }))
}
