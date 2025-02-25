//
//  NormalRecordView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import SwiftUI

import ComposableArchitecture

struct NormalRecordView: View {
    
    @Perception.Bindable var store: StoreOf<NormalRecordFeature>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                dateSection
                totalPrice
                
                // chart
                Rectangle()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                
                dateUnitPicker
                
                RecordTikkeulList(tikkeulDatas: store.currentDateUnit.tikkeuls)
                
            }
            .padding(.horizontal, 20)
        }
        .background(Color.background)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - UI Components
extension NormalRecordView {
    private var dateSection: some View {
        HStack(spacing: 16) {
            
            Text(store.dateRangeString)
            
            Spacer()
            
            Button {
                store.send(.previousDateButtonTapped)
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            
            Button {
                store.send(.nextDateButtonTapped)
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black)
            }
        }
    }
    
    private var totalPrice: some View {
        Text("\(store.totalMoney)원")
            .font(.largeTitle)
    }
    
    private var dateUnitPicker: some View {
        HStack {
            ForEach(RecordDateUnit.allCases, id: \.self) { dateUnit in
                Button {
                    store.send(.dateUnitChanged(dateUnit: dateUnit))
                } label: {
                    Text(dateUnit.title)
                        .foregroundStyle( dateUnit == store.currentDateUnit ? .black : .gray.opacity(0.6)
                        )
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(dateUnit == store.currentDateUnit ? .gray.opacity(0.6) : .clear,
                            lineWidth: 2
                        )
                )
            }
        }
    }
}

#Preview {
    NormalRecordView(
        store: Store(
            initialState: NormalRecordFeature.State(),
            reducer: {
                NormalRecordFeature()
            }, withDependencies: {
                
                $0.fetchTikkeulUseCase = FetchTikkeulUseCase(
                    repository: TikkeulRepository(
                        persistenceController: .testValue
                    )
                )
            }
        )
    )
}
