//
//  RecordTikkeulList.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/21/25.
//

import SwiftUI

struct RecordTikkeulList: View {
    
    let tikkeulDatas: [String: [PresentiableTikkeulData]]
    
    var body: some View {
        ForEach(tikkeulDatas.keys.sorted(by: >), id: \.self) { date in
            Section {
                ForEach(tikkeulDatas[date] ?? [], id: \.id) { item in
                    HomeTikkeulRow(tikkeul: item)
                }
            } header: {
                Text(date)
                    .padding(.top, 10)
            }
        }
    }
}

#Preview {
    RecordTikkeulList(tikkeulDatas: [:])
}
