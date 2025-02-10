//
//  SaveTikkeulView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import SwiftUI

struct SaveTikkeulView: View {
    @State var money: String = ""
    @State var content: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            HStack(spacing: 5) {
                
                TextField("0", text: $money)
                    .font(.system(size: 50, weight: .medium))
                    .multilineTextAlignment(.trailing)
                    .fixedSize()
                    .keyboardType(.numberPad)
                
                Text("원")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(spacing: 10) {
                
                HStack(spacing: 20) {
                    
                    Text("카테고리")
                        .frame(width: 60)
                    
                    Button {
                        
                    } label: {
                        Text("미분류")
                            .font(.title3)
                            .foregroundStyle(.gray.opacity(0.5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.top, 60)
                
                Divider()
                    .padding(.vertical, 8)
                
                
                HStack(spacing: 20) {
                    
                    Text("메모")
                        .frame(width: 60, alignment: .leading)
                    
                    TextField(
                        "",
                        text: $content,
                        prompt: Text("지출하지 않은 내용 작성")
                            .font(.title3)
                            .foregroundColor(.gray.opacity(0.5))
                    )
                        .font(.title3)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                }
                
                Divider()
                    .padding(.vertical, 8)
                
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("저장")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(.primaryMain)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.bottom, 10)
            
        }
        .padding(.horizontal, 20)
        .background(Color.background)
    }
}

#Preview {
    SaveTikkeulView()
}
