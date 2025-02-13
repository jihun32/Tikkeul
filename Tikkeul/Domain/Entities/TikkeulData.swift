//
//  Tikkeul.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

struct TikkeulData: Equatable {
    let id: String
    let money: Int
    let category: String
    let date: Date
    var memo: String?
}

extension TikkeulData {
    static let dummyData: [TikkeulData] = [
        TikkeulData(id: "1", money: 1000, category: "beauty", date: Date()),
        TikkeulData(id: "2", money: 1000, category: "coffee", date: Date()),
        TikkeulData(id: "3", money: 1000, category: "delivery", date: Date()),
        TikkeulData(id: "4", money: 1000, category: "drink", date: Date()),
        TikkeulData(id: "5", money: 1000, category: "entertainment", date: Date()),
        TikkeulData(id: "6", money: 1000, category: "hobby", date: Date()),
        TikkeulData(id: "7", money: 1000, category: "shopping", date: Date()),
        TikkeulData(id: "8", money: 1000, category: "snack", date: Date()),
        TikkeulData(id: "9", money: 1000, category: "transportation", date: Date())
    ]
}
