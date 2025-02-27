//
//  TikkeulCategory.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/5/25.
//

import Foundation
import SwiftUI

enum TikkeulCategory: String, CaseIterable {
    case snack
    case coffee
    case drink
    case food
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
        case .food:
            return "식비"
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
        case .food:
            return "🍚"
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
    
    var color: Color {
        switch self {
        case .snack:
            return Color(red: 1.0, green: 193/255, blue: 7/255)
        case .coffee:
            return Color(red: 121/255, green: 85/255, blue: 72/255)
        case .drink:
            return Color(red: 244/255, green: 67/255, blue: 54/255)
        case .food:
            return Color(red: 0/255, green: 150/255, blue: 136/255)
        case .shopping:
            return Color(red: 33/255, green: 150/255, blue: 243/255)
        case .entertainment:
            return Color(red: 156/255, green: 39/255, blue: 176/255)
        case .hobby:
            return Color(red: 76/255, green: 175/255, blue: 80/255)
        case .beauty:
            return Color(red: 233/255, green: 30/255, blue: 99/255)
        case .transportation:
            return Color(red: 158/255, green: 158/255, blue: 158/255)
        }
    }
}
