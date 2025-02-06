//
//  TikkeulRepository.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

protocol TikkeulRepository {
    func addTikkeul(item: Tikkeul) throws
    func deleteTikkeul(item: Tikkeul) throws
    func updateTikkeul(item: Tikkeul) throws
    func fetchTikkeul(item: Tikkeul) -> [Tikkeul] throws
}
