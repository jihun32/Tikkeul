//
//  PresentiableTikkeulData.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/5/25.
//

import Foundation

struct PresentiableTikkeulData: Identifiable, Hashable, Equatable {
    let id: UUID
    let money: Int
    let category: TikkeulCategory
    let time: String
    var memo: String?
}
