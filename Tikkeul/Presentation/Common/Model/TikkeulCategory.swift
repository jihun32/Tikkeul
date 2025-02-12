//
//  TikkeulCategory.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/5/25.
//

import Foundation

enum TikkeulCategory: CaseIterable {
    case snack
    case coffee
    case drink
    case delivery
    case shopping
    case entertainment
    case hobby
    case beauty
    case transportation
}

extension TikkeulCategory {
    var title: String {
        switch self {
        case .snack:
            return "간식"
        case .coffee:
            return "커피"
        case .drink:
            return "술/유흥"
        case .delivery:
            return "배달 음식"
        case .shopping:
            return "쇼핑"
        case .entertainment:
            return "문화/놀이"
        case .hobby:
            return "취미생활"
        case .beauty:
            return "미용"
        case .transportation:
            return "교통비"
        }
    }
    
    var emoji: String {
        switch self {
        case .snack:
            return "🍿"
        case .coffee:
            return "☕️"
        case .drink:
            return "🍻"
        case .delivery:
            return "🛵"
        case .shopping:
            return "🛍️"
        case .entertainment:
            return "🎉"
        case .hobby:
            return "🎨"
        case .beauty:
            return "💄"
        case .transportation:
            return "🚌"
        }
    }
}
