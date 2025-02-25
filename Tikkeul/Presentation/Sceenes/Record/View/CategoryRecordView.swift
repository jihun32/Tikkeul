//
//  CategoryRecordView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/25/25.
//

import Charts
import SwiftUI

import ComposableArchitecture


struct CategoryRecordView: View {
    let store: StoreOf<CategoryRecordFeature>
    
    let data: [CategoryRecordData] = [
        CategoryRecordData(category: .beauty, value: 40, money: 1000),
        CategoryRecordData(category: .coffee, value: 30, money: 10000),
        CategoryRecordData(category: .drink, value: 30, money: 100000)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                DateRangeSection(
                    text: "2월",
                    previousButtonTapped: {
                        
                    },
                    nextButtonTapped: {
                        
                    }
                )
                
                Chart(data, id: \.category) { item in
                    SectorMark(
                        angle: .value("Value", item.value)
                    )
                    .foregroundStyle(by: .value("Category", item.category.title))
                }
                .chartLegend(.hidden)
                .frame(width: 300, height: 300)
                
                
                VStack(spacing: 10) {
                    ForEach(data, id: \.category) { data in
                        HStack {
                            Circle()
                                .fill(data.category.color)
                                .frame(width: 5, height: 5)
                            
                            Text(data.category.title)
                            
                            Text("\(Int(data.value))%")
                                .fontWeight(.regular)
                                .font(.system(size: 12))
                                .foregroundStyle(.gray.opacity(0.8))
                            
                            Spacer()
                            
                            Text("\(data.money)원")
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}

#Preview {
    CategoryRecordView(
        store: Store(initialState: CategoryRecordFeature.State(), reducer: {
            CategoryRecordFeature()
        })
    )
}
