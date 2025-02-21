//
//  RecordTab.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/20/25.
//

import Foundation

enum RecordTab: CaseIterable {
    case normal
    case category
}

extension RecordTab {
    var title: String {
        switch self {
        case .normal:
            return "일반"
        case .category:
            return "카테고리"
        }
    }
}
