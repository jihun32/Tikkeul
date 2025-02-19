//
//  HomeTikkeulView.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/5/25.
//

import SwiftUI

import ComposableArchitecture

struct HomeTikkeulView: View {
    
    @Perception.Bindable var store: StoreOf<HomeFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    todayTikkeulMoney
                    
                    Divider()
                        .padding(.top, 5)
                    
                    Spacer()
                    
                    if !store.isEmptyTikkeulList {
                        HomeTikkeulList(tikkeulList: store.tikkeulList)
                    }
                }
                
                if store.isEmptyTikkeulList {
                    homeTikkeulEmptyView
                }
                
                VStack {
                    Spacer()
                    
                    addTikkeulButton
                        .padding(.bottom, 10)
                }
            }
            .padding(.horizontal, 20)
            .background(Color.background)
            .onAppear {
                store.send(.onAppear)
            }
        } destination: { store in
            SaveTikkeulView(store: store)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}



// MARK: - UI Components
extension HomeTikkeulView {
    
    private var todayTikkeulMoney: Text {
        Text("\(store.totalTikkeul)원")
            .font(.system(size: 60, weight: .regular))
            .foregroundColor(Color.primaryMain)
    }
    
    private var addTikkeulButton: some View {
        Button {
            store.send(.addTikkeulButtonTapped)
        } label: {
            Label("티끌 모으기", systemImage: "plus")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(.primaryMain)
        .clipShape(.capsule)
    }
    
    private var homeTikkeulEmptyView: some View {
        VStack(spacing: 10) {
            Image(.money)
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            Text("""
                오늘 기록한 티끌이 없어요.
                아래 버튼을 눌러 지출하지 않은 돈을 모아보세요!
                """)
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}


#Preview {
    withDependencies {
        $0.fetchTikkeulUseCase = FetchTikkeulUseCase(
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
        $0.addTikkeulUseCase = AddTikkeulUseCase(
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
        
        $0.updateTikkeulUseCase = UpdateTikkeulUseCase(
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
        
        $0.deleteTikkeulUseCase = DeleteTikkeulUseCase(
            repository: TikkeulRepository(
                persistenceController: .testValue
            )
        )
    } operation: {
        HomeTikkeulView(
            store: Store(
                initialState: HomeFeature.State(),
                reducer: { HomeFeature() }
            )
        )
    }
}
