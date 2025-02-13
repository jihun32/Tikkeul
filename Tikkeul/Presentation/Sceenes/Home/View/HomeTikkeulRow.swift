//
//  HomeTikkeulRow.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/5/25.
//

import SwiftUI

struct HomeTikkeulRow: View {
    let tikkeul: HomeTikkeulData
    
    var body: some View {
        HStack(spacing: 16) {
            categoryEmoji
            categoryTimeText
            
            Spacer()
            
            priceText
        }
        .frame(height: 100)
        .padding(.horizontal, 16)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
    }
}

// MARK: - UI Components
extension HomeTikkeulRow {
    
    private var categoryEmoji: some View {
        Text(tikkeul.category.emoji)
            .font(.system(size: 30))
            .background(
                Color.gray.opacity(0.1)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            )
    }
    
    private var categoryTimeText: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(tikkeul.category.title)
                .font(.system(size: 20))
            
            Text(tikkeul.time)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
    
    private var priceText: some View {
        Text("\(tikkeul.money) 원")
            .font(.system(size: 20))
    }
}

#Preview {
    HomeTikkeulRow(tikkeul: HomeTikkeulData(id: UUID(), money: 1000, category: .beauty, time: "01:00 PM"))
}
