//
//  RecordTobTabBar.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import SwiftUI

struct RecordTobTabBar: View {
    
    @Binding var selectedTab: RecordTab
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(RecordTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 5) {
                        Text(tab.title)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                        
                        if selectedTab == tab {
                            Color.black
                                .frame(width: 100, height: 1)
                                .matchedGeometryEffect(id: "underline", in: animationNamespace)
                        } else {
                            Color.clear
                                .frame(width: 100, height: 1)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RecordTobTabBar(selectedTab: .constant(.normal))
}
