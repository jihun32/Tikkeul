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
            
            dismissButton
            
            Spacer()
            
            moneyTextField
            
            VStack(spacing: 10) {
                categorySection
                
                Divider()
                    .padding(.vertical, 8)
                
                memoSection
                
                Divider()
                    .padding(.vertical, 8)
            }
            .padding(.top, 60)
            
            Spacer()
            
            BottomButton {
                
            }
        }
        .padding(.horizontal, 20)
        .background(Color.background)
    }
}

extension SaveTikkeulView {
    
    private var dismissButton: some View {
        HStack {
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.black)
            }
        }
    }
    
    private var moneyTextField: some View {
        HStack(spacing: 5) {
            TextField("0", text: $money)
                .font(.system(size: 60, weight: .medium))
                .multilineTextAlignment(.trailing)
                .fixedSize()
                .keyboardType(.numberPad)

            
            Text("원")
                .font(.system(size: 20, weight: .medium))

        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private var categorySection: some View {
        HStack(spacing: 20) {
            Text("카테고리")
                .frame(width: 60)
            
            Button(action: {
                
            }) {
                Text("미분류")
                    .font(.title3)
                    .foregroundStyle(.gray.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var memoSection: some View {
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
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    SaveTikkeulView()
}
