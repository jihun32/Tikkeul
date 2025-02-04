//
//  HomeView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/3/25.
//

import SwiftUI

struct HomeView: View {
    let todayTikkeuls: [Int] = []
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text("18,000원")
                    .font(.system(size: 60, weight: .regular))
                    .foregroundStyle(.primaryMain)

                Divider()
                    .padding(.top, 5)
                
                if !todayTikkeuls.isEmpty {
                } else {
                    Text("내역")
                        .foregroundStyle(.gray.opacity(0.6))
                        .font(.subheadline)
                        .padding(.top, 20)
                    
                    HStack(spacing: 16) {
                        Text("🍖")
                            .font(.system(size: 30))
                            .background(
                                Color.gray.opacity(0.1)
                                    .frame(width: 50, height: 50)
                                    .clipShape(.circle)
                            )
                        
                        VStack(alignment: .leading) {
                            Text("배달의 민족")
                                .font(.system(size: 20))
                            
                            Text("02:23 PM")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        Text("18,000원")
                            .font(.system(size: 20))
                    }
                    .frame(height: 100)
                    .padding(.horizontal, 16)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.top, 5)
                }
                
                Spacer()
                
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
            .padding(.horizontal, 20)
            .background(Color.background)
            .navigationTitle(Text("오늘의 티끌"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    HomeView()
}
