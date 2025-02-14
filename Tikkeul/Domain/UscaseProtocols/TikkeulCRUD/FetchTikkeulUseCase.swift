//
//  FetchTikkeulUseCaseProtocol.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import Foundation

protocol FetchTikkeulUseCaseProtocol {
    func fetchTikkeul(from startDate: Date, to endDate: Date) throws -> [TikkeulData]
}
