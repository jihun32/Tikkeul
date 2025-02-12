//
//  SaveTikkeulView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import SwiftUI

import ComposableArchitecture

struct SaveTikkeulView: View {
    
    @Perception.Bindable var store: StoreOf<SaveTikkeulFeature>
    
    var body: some View {
        VStack(spacing: 0) {
            
            dismissButton
                .padding(.top, 16)
            
            Spacer()
            
            moneyTextField
            
            VStack(spacing: 10) {
                categorySection
                
                Divider()
                    .padding(.vertical, 4)
                
                memoSection
                
                Divider()
                    .padding(.vertical, 4)
            }
            .padding(.top, 60)
            
            Spacer()
            
            BottomButton {
                
            }
        }
        .padding(.horizontal, 20)
        .background(Color.background)
        .sheet(
            item: $store.scope(
                state: \.choiceCategory,
                action: \.choiceCategory
            )) { choiceCategoryFeature in
                ChoiceCategoryView(
                    store: choiceCategoryFeature
                )
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(280)])
            }
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
            TextField("0", text: $store.moneyText.sending(\.moneyTextFieldDidChange))
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
                store.send(.categoryButtonTapped)
            }) {
                Text("미분류")
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
                text: $store.memoText.sending(\.memoTextFieldDidChange),
                prompt: Text("지출하지 않은 내용 작성")
                    .foregroundColor(.gray.opacity(0.5))
            )
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    SaveTikkeulView(store: Store(initialState: SaveTikkeulFeature.State(), reducer: {
        SaveTikkeulFeature()
    }))
}
