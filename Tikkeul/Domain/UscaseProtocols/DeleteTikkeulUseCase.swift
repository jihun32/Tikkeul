//
//  DeleteTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

protocol DeleteTikkeulUseCase {
    func deleteTikkeul(item: Tikkeul) throws
}
