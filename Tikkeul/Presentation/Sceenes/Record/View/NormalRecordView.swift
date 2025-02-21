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
                dateSection
                totalPrice
                
                // chart
                Rectangle()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                
                dateUnitPicker
                
                RecordTikkeulList(tikkeulDatas: tikkeulDatas)
                
            }
            .padding(.horizontal, 20)
        }
        .background(Color.background)
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
        Picker("", selection: $selectedDateUnit) {
            ForEach(RecordDateUnit.allCases, id: \.self) { dateUnit in
                Text(dateUnit.title)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 160)
    }
}

#Preview {
    NormalRecordView()
}
