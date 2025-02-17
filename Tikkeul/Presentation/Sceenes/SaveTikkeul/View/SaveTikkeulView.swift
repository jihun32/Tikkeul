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
            
            saveButton
        }
        .padding(.horizontal, 20)
        .background(Color.background)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton {
                    store.send(.delegate(.backButtonTapped))
                }
            }
        }
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
    
    private var moneyTextField: some View { 
        HStack(spacing: 5) {
            
            CommaFomattedUITextField(
                text: $store.moneyText.sending(\.moneyTextFieldDidChange),
                placeholder: "0",
                maxCount: 8,
                font: UIFont.systemFont(ofSize: 60, weight: .medium),
                textAlignment: .right
            )
                .fixedSize()

            
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
                Text(store.categoryText ?? "미분류")
                    .foregroundStyle(store.categoryText == nil ? .gray.opacity(0.5) : .black)
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
            .onChange(of: store.memoText) { newValue in
                if newValue.count > 10 {
                    store.send(.memoTextFieldDidChange(memo: String(newValue.prefix(10))))
                }
            }
            
            Spacer()
            
            Text(store.memoCountText)
        }
    }
    
    private var saveButton: some View {
        BottomButton(
            title: "저장",
            backgroundColor: store.isEnableSaveButton ? .primaryMain : .gray.opacity(0.3)) {
            store.send(.delegate(.saveButtonTapped))
        }
        .disabled(!store.isEnableSaveButton)
    }
}

#Preview {
    SaveTikkeulView(store: Store(initialState: SaveTikkeulFeature.State(), reducer: {
        SaveTikkeulFeature()
    }))
}
