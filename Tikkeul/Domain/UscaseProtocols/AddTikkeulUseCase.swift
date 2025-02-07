//
//  AddTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

protocol AddTikkeulUseCase {
    func addTikkeul(item: TikkeulData) -> [TikkeulData]
}
