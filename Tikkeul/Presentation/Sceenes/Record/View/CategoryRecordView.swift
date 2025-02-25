//
//  CategoryRecordView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/25/25.
//

import SwiftUI

import ComposableArchitecture

struct CategoryRecordView: View {
    let store: StoreOf<CategoryRecordFeature>
    
    var body: some View {
        Text("category")
    }
}

#Preview {
    CategoryRecordView(
        store: Store(initialState: CategoryRecordFeature.State(), reducer: {
            CategoryRecordFeature()
        })
    )
}
