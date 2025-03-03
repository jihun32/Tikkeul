//
//  BottomButton.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/10/25.
//

import SwiftUI

struct BottomButton: View {
    
    var title: String
    var backgroundColor: Color
    
    var onTapped: () -> Void
    
    var body: some View {
        Button {
            onTapped()
        } label: {
            Text(title)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.bottom, 10)
    }
}

#Preview {
    BottomButton(title: "저장", backgroundColor: .primaryMain , onTapped: { })
}
