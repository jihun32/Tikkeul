//
//  DateFormat.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/14/25.
//

import Foundation

enum DateFormat: String {
    case timeAMorPM = "hh:mm a"
    case mm_dd = "MM-dd"
    case m = "M월"
}

extension DateFormat {
    
    /// `DateFormatter` 객체를 캐싱하여 재사용하기 위한 `NSCache`
    private static var cachedFormatters: NSCache<NSString, DateFormatter> = .init()
    
    /// 현재 `DateFormat` 값에 해당하는 `DateFormatter`를 반환
    /// - 캐싱된 `DateFormatter`가 있으면 반환하고, 없으면 생성하여 캐싱함.
    var formatter: DateFormatter {
        Self.cachedFormatter(ofDateFormat: rawValue)
    }

    /// 주어진 날짜 포맷 문자열에 해당하는 `DateFormatter`를 반환
    static func cachedFormatter(ofDateFormat dateFormat: String) -> DateFormatter {
        let dateFormatKey = NSString(string: dateFormat)
        
        // 캐시에 존재하면 즉시 반환
        if let cachedFormatter = cachedFormatters.object(forKey: dateFormatKey) {
            return cachedFormatter
        }

        // 없으면 새로 생성 후 캐시에 저장
        let formatter = makeFormatter(withDateFormat: dateFormat)
        cachedFormatters.setObject(formatter, forKey: dateFormatKey)
        return formatter
    }

    /// 새로운 `DateFormatter`를 생성하는 메서드
    private static func makeFormatter(withDateFormat dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
}
