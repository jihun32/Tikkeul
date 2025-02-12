//
//  ChoiceCategoryView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/12/25.
//

import SwiftUI

import ComposableArchitecture

struct ChoiceCategoryView: View {
    
    let store: StoreOf<ChoiceCategoryFeature>
    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            categoryItems
        }
        .padding()
    }
}

// MARK: - UI Components
extension ChoiceCategoryView {
    private var categoryItems: some View {
        ForEach(store.categories, id: \.title) { category in
            Button {
                store.send(.categoryItemTapped(category: category))
            } label: {
                VStack(spacing: 5) {
                    categoryItem
                }
            }
        }
    }
    
    private var categoryItem: some View {
        Text(category.emoji)
            .font(.system(size: 40))
        
        Text(category.title)
            .font(.caption)
            .bold()
            .foregroundStyle(.black)
    }
}

#Preview {
    ChoiceCategoryView(store: Store(initialState: ChoiceCategoryFeature.State()) {
        ChoiceCategoryFeature()
    })
}
