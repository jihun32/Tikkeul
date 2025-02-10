//
//  BottomButton.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/10/25.
//

import SwiftUI

struct BottomButton: View {
    
    var onTapped: () -> Void
    
    var body: some View {
        Button(action: {
            
        }) {
            Text("저장")
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.primaryMain)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.bottom, 10)
    }
}

#Preview {
    BottomButton(onTapped: { })
}
