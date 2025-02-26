//
//  RecordDateUnit.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import Foundation

enum RecordDateUnit: CaseIterable, Hashable {
    static let allCases: [RecordDateUnit] = [
        .weekly(ago: 0, data: [:]),
        .monthly(ago: 0, data: [:])
    ]
    
    case weekly(ago: Int, data: [String: [PresentiableTikkeulData]])
    case monthly(ago: Int, data: [String: [PresentiableTikkeulData]])
}

extension RecordDateUnit {
    var title: String {
        switch self {
        case .weekly:
            return "주간"
        case .monthly:
            return "월간"
        }
    }
    
    var ago: Int {
        get {
            switch self {
            case .weekly(let ago, _), .monthly(let ago, _):
                return ago
            }
        }
        set {
            switch self {
            case .weekly(_, let data):
                self = .weekly(ago: newValue, data: data)
            case .monthly(_, let data):
                self = .monthly(ago: newValue, data: data)
            }
        }
    }
    
    var tikkeuls: [String: [PresentiableTikkeulData]] {
        get {
            switch self {
            case .weekly(_, let data), .monthly(_, let data):
                return data
            }
        }
        set {
            switch self {
            case .weekly(let ago, _):
                self = .weekly(ago: ago, data: newValue)
            case .monthly(let ago, _):
                self = .monthly(ago: ago, data: newValue)
            }
        }
    }
    
    var cacheKey: String {
        switch self {
        case .weekly(let ago, _):
            return "weekly_\(ago)"
        case .monthly(let ago, _):
            return "monthly_\(ago)"
        }
    }
}

extension RecordDateUnit: Equatable {
    static func == (lhs: RecordDateUnit, rhs: RecordDateUnit) -> Bool {
        switch (lhs, rhs) {
        case (.weekly(_, _), .weekly(_, _)):
            return true
        case (.monthly(_, _), .monthly(_, _)):
            return true
        default:
            return false
        }
    }
}
