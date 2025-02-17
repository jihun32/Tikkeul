//
//  NavigationBackButton.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/17/25.
//

import SwiftUI

struct NavigationBackButton: View {
    var onTapped: () -> Void
    
    var body: some View {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                onTapped()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    NavigationBackButton { }
}

