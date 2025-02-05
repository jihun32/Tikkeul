//
//  HomeTikkeulView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/5/25.
//

import SwiftUI

struct HomeTikkeulView: View {
    let tikkeulList: [HomeTikkeulData]
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                todayTikkeulMoney
                
                Divider()
                    .padding(.top, 5)
                
                Spacer()
                
                if !tikkeulList.isEmpty {
                    HomeTikkeulList(tikkeulList: tikkeulList)
                }
            }
            
            if tikkeulList.isEmpty {
                homeTikkeulEmptyView
            }
            
            VStack {
                Spacer()
                
                addTikkeulButton
                    .padding(.bottom, 10)
            }
        }
        .padding(.horizontal, 20)
        .background(Color.background)
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}



// MARK: - UI Components
extension HomeTikkeulView {
    
    private var navigationTitle: Text {
        Text("오늘의 티끌")
    }
    
    private var todayTikkeulMoney: Text {
        Text("18,000원")
            .font(.system(size: 60, weight: .regular))
            .foregroundColor(Color.primaryMain)
    }
    
    private var addTikkeulButton: some View {
        Button {
            
        } label: {
            Label("티끌 모으기", systemImage: "plus")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(.primaryMain)
        .clipShape(.capsule)
    }
    
    private var homeTikkeulEmptyView: some View {
        VStack(spacing: 10) {
            Image(.money)
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            Text("""
                오늘 기록한 티끌이 없어요.
                아래 버튼을 눌러 지출하지 않은 돈을 모아보세요!
                """)
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}


#Preview {
    HomeTikkeulView(tikkeulList: HomeTikkeulData.data)
}
