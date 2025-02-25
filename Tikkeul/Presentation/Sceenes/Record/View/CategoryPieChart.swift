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
        .chartLegend(.hidden)
        .frame(width: 250, height: 250)
    }
}

#Preview {
    CategoryPieChart(categoryData: [])
}
