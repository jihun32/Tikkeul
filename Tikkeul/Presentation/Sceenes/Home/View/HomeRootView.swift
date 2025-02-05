//
//  HomeRootView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/3/25.
//

import SwiftUI

struct HomeRootView: View {
    let tikkeulList: [HomeTikkeulData] = HomeTikkeulData.data
    
    var body: some View {
        NavigationStack {
            HomeTikkeulView(tikkeulList: tikkeulList)
        }
    }
}

#Preview {
    HomeRootView()
}
