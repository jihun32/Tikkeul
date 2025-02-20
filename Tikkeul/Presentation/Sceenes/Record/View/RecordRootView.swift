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
        VStack {
            
            RecordTobTabBar(selectedTab: $selectedTab)
            
            Spacer()
        }
    }
}

#Preview {
    RecordRootView()
}
