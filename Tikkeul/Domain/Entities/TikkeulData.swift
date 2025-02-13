//
//  Tikkeul.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

struct TikkeulData: Equatable {
    let id: UUID
    let money: Int
    let category: String
    let date: Date
    var memo: String?
}

extension TikkeulData {
    static let dummyData: [TikkeulData] = {
        let baseDate = Date()
        return [
            TikkeulData(id: UUID(), money: 1000, category: "beauty", date: baseDate),
            TikkeulData(id: UUID(), money: 1000, category: "coffee", date: Calendar.current.date(byAdding: .hour, value: 1, to: baseDate)!),
            TikkeulData(id: UUID(), money: 1000, category: "delivery", date: Calendar.current.date(byAdding: .hour, value: 2, to: baseDate)!),
            TikkeulData(id: UUID(), money: 1000, category: "drink", date: Calendar.current.date(byAdding: .hour, value: 3, to: baseDate)!, memo: "test")
        ]
    }()
}
