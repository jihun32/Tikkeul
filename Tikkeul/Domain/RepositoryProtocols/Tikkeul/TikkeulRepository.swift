//
//  TikkeulRepository.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

protocol TikkeulRepository {
    func addTikkeul(item: TikkeulData) throws -> [TikkeulData]
    func deleteTikkeul(item: TikkeulData) throws -> [TikkeulData]
    func updateTikkeul(item: TikkeulData) throws -> [TikkeulData]
    func fetchTikkeul(item: TikkeulData) throws -> [TikkeulData]
}
