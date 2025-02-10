//
//  AddTikkeulUseCaseProtocol.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

protocol AddTikkeulUseCaseProtocol {
    func addTikkeul(item: TikkeulData, items: [TikkeulData]) -> [TikkeulData]
}
