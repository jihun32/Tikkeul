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
                
                RecordTikkeulList(tikkeulDatas: store.currentTikkeuls)
                
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
            
            Text("02.17 ~ 02.23")
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            
            Button {
                
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black)
            }
        }
    }
    
    private var totalPrice: some View {
        Text("100,000원")
            .font(.largeTitle)
    }
    
    private var dateUnitPicker: some View {
        Picker("", selection: $store.currentDateUnit.sending(\.dateUnitChanged)) {
            ForEach(RecordDateUnit.allCases, id: \.self) { dateUnit in
                Text(dateUnit.title)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 160)
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
