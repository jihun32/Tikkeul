//
//  String+Extensions.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/17/25.
//

import Foundation

extension String {
    /// 문자열을 `DateFormat`에 맞춰 변환한 후, 특정 날짜의 해당 시간으로 변환
    /// - Parameters:
    ///   - dateFormat: 변환할 `DateFormat`
    ///   - baseDate: 기준 날짜 (기본값: 오늘)
    /// - Returns: 기준 날짜의 해당 시간으로 변환된 `Date`
    func toDate(on baseDate: Date = Date(), with dateFormat: DateFormat) -> Date? {
        guard let timeDate = dateFormat.formatter.date(from: self) else {
            return nil
        }
        
        let calendar = Calendar.current
        let baseDay = calendar.startOfDay(for: baseDate)
        
        let hour = calendar.component(.hour, from: timeDate)
        let minute = calendar.component(.minute, from: timeDate)

        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: baseDay)
    }
}
