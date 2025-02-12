//
//  ChoiceCategoryView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/12/25.
//

import SwiftUI

struct ChoiceCategoryView: View {
    let categories: [TikkeulCategory] = TikkeulCategory.allCases
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(categories, id: \.title) { category in
                VStack(spacing: 5) {
                    
                    Text(category.emoji)
                        .font(.system(size: 40))
                    
                    Text(category.title)
                        .font(.caption)
                        .bold()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ChoiceCategoryView()
}
