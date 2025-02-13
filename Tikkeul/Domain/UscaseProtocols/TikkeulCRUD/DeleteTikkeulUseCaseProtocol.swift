//
//  DeleteTikkeulUseCaseProtocol.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/7/25.
//

import Foundation

protocol DeleteTikkeulUseCaseProtocol {
    func deleteTikkeul(item: TikkeulData) throws
}
