//
//  NormalRecordView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import SwiftUI

struct NormalRecordView: View {
    
    @State private var selectedDateUnit: RecordDateUnit = .weekly
    @State private var tikkeulDatas: [String: [PresentiableTikkeulData]] = [:]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
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
                
                Text("100,000원")
                    .font(.largeTitle)
                
                Rectangle()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                
                Picker("", selection: $selectedDateUnit) {
                    ForEach(RecordDateUnit.allCases, id: \.self) { dateUnit in
                        Text(dateUnit.title)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 160)
                
                ForEach(tikkeulDatas.keys.sorted(by: >), id: \.self) { date in
                    Section {
                        ForEach(tikkeulDatas[date] ?? [], id: \.id) { item in
                            HomeTikkeulRow(tikkeul: item)
                        }
                    } header: {
                        Text(date)
                            .padding(.top, 10)
                    }
                }
                
            }
            .padding(.horizontal, 20)
        }
        .background(Color.background)
        .onAppear {
            // 기존 데이터를 PresentiableTikkeulData로 변환
            let presentableData = TikkeulData.dummyData.compactMap { data -> PresentiableTikkeulData? in
                guard let category = TikkeulCategory(rawValue: data.category) else { return nil }

                return PresentiableTikkeulData(
                    id: data.id,
                    money: data.money,
                    category: category,
                    time: data.date.formattedString(dateFormat: .timeAMorPM),
                    memo: data.memo
                )
            }

            // 날짜별 그룹화 (Dictionary with String keys)
            tikkeulDatas = Dictionary(grouping: presentableData) { data in
                let originalDate = TikkeulData.dummyData.first { $0.id == data.id }?.date ?? Date()
                return originalDate.formattedString(dateFormat: .mm_dd)
            }

            // 날짜별 정렬 (최신 날짜가 위로 오도록 내림차순 정렬)
            tikkeulDatas = tikkeulDatas.sorted { $0.key > $1.key }
                .reduce(into: [:]) { $0[$1.key] = $1.value }
        }
    }
}

#Preview {
    NormalRecordView()
}
