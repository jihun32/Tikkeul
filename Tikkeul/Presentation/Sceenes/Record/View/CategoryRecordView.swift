//
//  CategoryRecordView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/25/25.
//

import SwiftUI

import ComposableArchitecture

struct CategoryRecordView: View {
    let store: StoreOf<CategoryRecordFeature>
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                dateRangeSection
                
                CategoryPieChart(categoryData: store.categoryData)
                
                categoryDataList
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - UI Components
extension CategoryRecordView {
    private var dateRangeSection: some View {
        DateRangeSection(
            text: store.monthString,
            previousButtonTapped: {
                store.send(.previousButtonTapped)
            },
            nextButtonTapped: {
                store.send(.nextButtonTapped)
            }
        )
    }
    
    private var categoryDataList: some View {
        VStack(spacing: 10) {
            ForEach(store.categoryData, id: \.category) { data in
                categoryDataRow(data: data)
            }
        }
    }
    
    @ViewBuilder
    private func categoryDataRow(data: CategoryRecordData) -> some View {
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
