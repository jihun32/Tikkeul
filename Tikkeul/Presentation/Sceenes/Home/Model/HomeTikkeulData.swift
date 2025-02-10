//
//  HomeTikkeulData.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/5/25.
//

import Foundation

struct HomeTikkeulData: Identifiable {
    let id: UUID
    let money: Int
    let category: TikkeulCategory
    let time: String
}

extension HomeTikkeulData {
    static let data: [HomeTikkeulData] = [
        HomeTikkeulData(id: UUID(), money: 1000, category: .beauty, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .coffee, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .delivery, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .drink, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .entertainment, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .hobby, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .shopping, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .snack, time: "01:00 PM"),
        HomeTikkeulData(id: UUID(), money: 1000, category: .transportation, time: "01:00 PM")
    ]
}
