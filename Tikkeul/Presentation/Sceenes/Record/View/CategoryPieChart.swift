//
//  CategoryPieChart.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/25/25.
//

import Charts
import SwiftUI

struct CategoryPieChart: View {
    
    let categoryData: [CategoryRecordData]
    
    var body: some View {
        
        Chart(categoryData, id: \.category) { item in
            SectorMark(
                angle: .value("Value", item.value),
                angularInset: 1.5
            )
            .foregroundStyle(by: .value("Category", item.category.title))
        }
        .chartForegroundStyleScale([
            TikkeulCategory.snack.title: TikkeulCategory.snack.color,
            TikkeulCategory.coffee.title: TikkeulCategory.coffee.color,
            TikkeulCategory.drink.title: TikkeulCategory.drink.color,
            TikkeulCategory.food.title: TikkeulCategory.food.color,
            TikkeulCategory.shopping.title: TikkeulCategory.shopping.color,
            TikkeulCategory.entertainment.title: TikkeulCategory.entertainment.color,
            TikkeulCategory.hobby.title: TikkeulCategory.hobby.color,
            TikkeulCategory.beauty.title: TikkeulCategory.beauty.color,
            TikkeulCategory.transportation.title: TikkeulCategory.transportation.color
        ])
        .chartLegend(.hidden)
        .frame(width: 250, height: 250)
    }
}

#Preview {
    CategoryPieChart(categoryData: [])
}
