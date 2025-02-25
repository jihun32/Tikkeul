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
                
                Chart(store.categoryData, id: \.category) { item in
                    SectorMark(
                        angle: .value("Value", item.value),
                        angularInset: 1.5
                    )
                    .foregroundStyle(by: .value("Category", item.category.title))
                }
                .chartLegend(.hidden)
                .frame(width: 300, height: 300)
                
                
                VStack(spacing: 10) {
                    ForEach(store.categoryData, id: \.category) { data in
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
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    CategoryRecordView(
        store: Store(initialState: CategoryRecordFeature.State(), reducer: {
            CategoryRecordFeature()
        }, withDependencies: {
            
            $0.fetchTikkeulUseCase = FetchTikkeulUseCase(
                repository: TikkeulRepository(
                    persistenceController: .testValue
                )
            )
        })
    )
}
