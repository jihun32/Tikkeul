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
    var endOfDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self.startOfDay)
    }
    
    /// 주 단위 날짜 범위를 반환합니다.
    /// - Parameter weeksAgo: 0이면 이번 주, 1이면 저번 주, 2이면 저저번 주
    /// - Returns: 주의 시작 날짜부터 종료 날짜(exclusive)까지의 범위
    func getWeekRange(weeksAgo: Int) -> Range<Date>? {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: self)?.start
        guard let startOfTargetWeek = calendar.date(byAdding: .weekOfYear, value: weeksAgo, to: startOfWeek ?? self) else {
            return nil
        }
        guard let endOfTargetWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfTargetWeek) else {
            return nil
        }
        return startOfTargetWeek..<endOfTargetWeek
    }
    
    /// 월 단위 날짜 범위를 반환합니다.
    /// - Parameter monthsAgo: 0이면 이번 달, 1이면 저번 달, 2이면 저저번 달
    /// - Returns: 월의 시작 날짜부터 종료 날짜(exclusive)까지의 범위
    func getMonthRange(monthsAgo: Int) -> Range<Date>? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        let startOfMonth =  calendar.date(from: components)
    
        guard let startOfTargetMonth = calendar.date(byAdding: .month, value: monthsAgo, to: startOfMonth ?? self) else {
            return nil
        }
        guard let endOfTargetMonth = calendar.date(byAdding: .month, value: 1, to: startOfTargetMonth) else {
            return nil
        }
        return startOfTargetMonth..<endOfTargetMonth
    }
    
    /// 주어진 포맷으로 날짜를 문자열로 변환
    func formattedString(dateFormat: DateFormat) -> String {
        return dateFormat.formatter.string(from: self)
    }
}
