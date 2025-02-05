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
        
        ZStack(alignment: .bottom) {
            
            VStack(alignment: .leading, spacing: 0) {
                todayTikkeulMoney
                
                Divider()
                    .padding(.top, 5)
                
                HomeTikkeulList(tikkeulList: tikkeulList)
            }
            
            gatherButton
                .padding(.bottom, 10)
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
    
    private var gatherButton: some View {
        Button {
            
        } label: {
            Group {
                Text("티끌 모으기 ") +
                Text(Image(systemName: "plus"))
            }
            .font(.headline)
            .foregroundStyle(.white)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(.primaryMain)
        .clipShape(.capsule)
    }
}


#Preview {
    HomeTikkeulView(tikkeulList: HomeTikkeulData.data)
}
