//
//  HomeTikkeulList.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/4/25.
//

import SwiftUI

struct HomeTikkeulList: View {
    var tikkeulList: [HomeTikkeulData]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                historyText
                    .padding(.top, 20)
                
                ForEach(tikkeulList) { tikkeul in
                    HomeTikkeulRow(tikkeul: tikkeul)
                }
            }
        }
    }
}

// MARK: - UI Components
extension HomeTikkeulList {
    private var historyText: some View {
        Text("내역")
            .foregroundStyle(.gray.opacity(0.6))
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeTikkeulList(tikkeulList: [HomeTikkeulData(id: UUID(), money: 1000, category: .beauty, time: "01:00 PM")])
}
