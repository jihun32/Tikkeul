//
//  Tikkeul.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

struct TikkeulData: Equatable {
    let id: UUID
    var money: Int
    var category: String
    var date: Date
    var memo: String?
}

extension TikkeulData {
    static let dummyData: [TikkeulData] = {
        let calendar = Calendar.current
        let now = Date()

        let thisWeek = now
        let lastWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: now)!
        let lastMonth = calendar.date(byAdding: .month, value: -1, to: now)!

        return [
            // 오늘 데이터
            TikkeulData(id: UUID(), money: 5000, category: "coffee", date: calendar.date(byAdding: .hour, value: -1, to: thisWeek)!),
            TikkeulData(id: UUID(), money: 12000, category: "delivery", date: calendar.date(byAdding: .hour, value: -3, to: thisWeek)!),
            TikkeulData(id: UUID(), money: 15000, category: "drink", date: thisWeek, memo: "Weekend Drinks"),

            // 이번, 저번 주 데이터
            TikkeulData(id: UUID(), money: 8000, category: "coffee", date: calendar.date(byAdding: .day, value: -6, to: lastWeek)!),
            TikkeulData(id: UUID(), money: 2000, category: "delivery", date: calendar.date(byAdding: .day, value: -4, to: lastWeek)!),
            TikkeulData(id: UUID(), money: 4000, category: "drink", date: lastWeek, memo: "After Work"),
            TikkeulData(id: UUID(), money: 5000, category: "beauty", date: calendar.date(byAdding: .day, value: -2, to: lastWeek)!),

            // 이번 달 데이터
            TikkeulData(id: UUID(), money: 9000, category: "coffee", date: calendar.date(byAdding: .day, value: -10, to: lastWeek)!),
            TikkeulData(id: UUID(), money: 3000, category: "delivery", date: calendar.date(byAdding: .day, value: -12, to: lastWeek)!),
            TikkeulData(id: UUID(), money: 5000, category: "drink", date: calendar.date(byAdding: .day, value: -5, to: lastWeek)!, memo: "Friends Meetup"),
            TikkeulData(id: UUID(), money: 6000, category: "beauty", date: calendar.date(byAdding: .day, value: -7, to: lastWeek)!),

            // 저번 달 데이터
            TikkeulData(id: UUID(), money: 10000, category: "coffee", date: calendar.date(byAdding: .day, value: -20, to: lastMonth)!),
            TikkeulData(id: UUID(), money: 7000, category: "delivery", date: calendar.date(byAdding: .day, value: -18, to: lastMonth)!),
            TikkeulData(id: UUID(), money: 8000, category: "drink", date: calendar.date(byAdding: .day, value: -15, to: lastMonth)!, memo: "Office Party"),
            TikkeulData(id: UUID(), money: 9000, category: "beauty", date: calendar.date(byAdding: .day, value: -25, to: lastMonth)!)
        ]
    }()
}
