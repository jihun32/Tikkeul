//
//  TikkeulRepositoryProtocol.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

protocol TikkeulRepositoryProtocol {
    func addTikkeul(item: TikkeulData, items: [TikkeulData]) -> [TikkeulData]
    func deleteTikkeul(item: TikkeulData, items: [TikkeulData]) -> [TikkeulData]?
    func updateTikkeul(item: TikkeulData, items: [TikkeulData]) -> [TikkeulData]?
    func fetchTikkeul() -> [TikkeulData]
}
