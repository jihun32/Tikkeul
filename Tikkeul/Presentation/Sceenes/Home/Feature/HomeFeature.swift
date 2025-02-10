//
//  HomeFeature.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/10/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct HomeFeature {
    
    @ObservableState
    struct State {
        var tikkeulList: [HomeTikkeulData] = HomeTikkeulData.data
        
        var isEmptyTikkeulList: Bool {
            tikkeulList.isEmpty
        }
        
        var totalTikkeul: Int {
            tikkeulList
                .map { $0.money }
                .reduce(0, +)
        }
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
    
}
