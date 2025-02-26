//
//  RecordRootView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import SwiftUI

import ComposableArchitecture

struct RecordView: View {
    
    @Bindable var store: StoreOf<RecordFeature>

    var body: some View {
        VStack(spacing: 0) {
            
            Text("기록")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 5)
            
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
                CategoryRecordView(
                    store: store.scope(
                        state: \.categoryRecord,
                        action: \.categoryRecord
                    )
                )
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
