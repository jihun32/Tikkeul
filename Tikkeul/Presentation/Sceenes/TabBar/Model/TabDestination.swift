//
//  TabDestination.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/3/25.
//

import Foundation

enum TabDestination: CaseIterable {
    case home
    case record
    case settings
}

extension TabDestination {
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .record:
            return "chart.bar.xaxis.ascending"
        case .settings:
            return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .record:
            return "기록"
        case .settings:
            return "설정"
        }
    }
}


