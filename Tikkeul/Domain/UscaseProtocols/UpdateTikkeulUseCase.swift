//
//  UpdateTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

protocol UpdateTikkeulUseCase {
    func updateTikkeul(item: TikkeulData) -> [TikkeulData]?
}
