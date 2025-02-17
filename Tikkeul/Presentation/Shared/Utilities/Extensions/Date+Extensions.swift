//
//  Date+Extensions.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import Foundation

extension Date {
    
    /// 현재 날짜의 자정(시작)을 반환합니다.
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /// 현재 날짜의 종료 시각(다음날 자정)을 반환합니다.
    var endOfDay: Date {
        guard let end = Calendar.current.date(byAdding: .day, value: 1, to: self.startOfDay) else {
            fatalError("날짜 계산 실패")
        }
        return end
    }
    
    /// 현재 날짜가 속한 주의 시작 날짜(주간 시작)를 반환합니다.
    var startOfWeek: Date {
        guard let start = Calendar.current.dateInterval(of: .weekOfYear, for: self)?.start else {
            fatalError("주 시작 날짜 계산 실패")
        }
        return start
    }
    
    /// 현재 날짜가 속한 주의 종료 시각(다음 주 시작)을 반환합니다.
    var endOfWeek: Date {
        guard let end = Calendar.current.date(byAdding: .day, value: 7, to: startOfWeek) else {
            fatalError("주 종료 날짜 계산 실패")
        }
        return end
    }
    
    /// 현재 날짜가 속한 월의 시작 날짜를 반환합니다.
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        guard let start = Calendar.current.date(from: components) else {
            fatalError("월 시작 날짜 계산 실패")
        }
        return start
    }
    
    /// 현재 날짜가 속한 월의 종료 시각(다음 달 시작)을 반환합니다.
    var endOfMonth: Date {
        guard let end = Calendar.current.date(byAdding: .month, value: 1, to: self.startOfMonth) else {
            fatalError("다음 달 시작 날짜 계산 실패")
        }
        return end
    }
    
    
    func formattedString(dateFormat: DateFormat) -> String {
        // 딕셔너리로 캐싱된 DateFormatter 를 재사용
        return dateFormat.formatter.string(from: self)
    }
}
