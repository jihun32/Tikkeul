//
//  DateRangeSection.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/25/25.
//

import SwiftUI

struct DateRangeSection: View {
    let text: String
    var previousButtonTapped: () -> Void
    var nextButtonTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            
            Text(text)
                .font(.title2)
            
            Spacer()
            
            Button {
                previousButtonTapped()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            
            Button {
                nextButtonTapped()
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    DateRangeSection(text: "test", previousButtonTapped: { }, nextButtonTapped: { })
}
