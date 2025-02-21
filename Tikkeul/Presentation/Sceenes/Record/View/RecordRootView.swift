//
//  RecordRootView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import SwiftUI

//
//  RecordRootView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import SwiftUI

struct RecordRootView: View {
    @State private var selectedTab: RecordTab = .normal

    var body: some View {
        VStack(spacing: 30) {
            
            RecordTobTabBar(selectedTab: $selectedTab)
            
            switch selectedTab {
                
            case .normal:
                NormalRecordView()
                
            case .category:
                Text("카테고리")
            }
            
            Spacer()
        }
    }
}

#Preview {
    RecordRootView()
}
