//
//  RecordDateUnit.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import Foundation

enum RecordDateUnit: CaseIterable {
    case weekly
    case monthly
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
}
