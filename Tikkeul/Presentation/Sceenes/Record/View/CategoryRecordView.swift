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
                categoryDataView
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
    
    @ViewBuilder
    private var categoryDataView: some View {
        if let categoryData = store.categoryData  {
            if categoryData.isEmpty {
                emptyDataView
            } else {
                CategoryPieChart(categoryData: categoryData)
                
                categoryDataList(for: categoryData)
            }
        }
    }
    
    private var emptyDataView: some View {
        VStack {
            Image(.noChartData)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .padding(.top, 100)
            
            Text("아직 모은 티끌이 없어요.")
                .padding(.top, 10)
        }
    }
    
    private func categoryDataList(for data: [CategoryRecordData]) -> some View {
        VStack(spacing: 10) {
            ForEach(data, id: \.category) { item in
                categoryDataRow(data: item)
            }
        }
    }
    
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
