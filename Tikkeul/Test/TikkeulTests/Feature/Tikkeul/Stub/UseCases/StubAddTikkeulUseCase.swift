//
//  StubAddTikkeulUseCase.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/6/25.
//

import Foundation

final class StubAddTikkeulUseCase: AddTikkeulUseCase {
    func addTikkeul(item: TikkeulData) -> [TikkeulData] {
        var items = TikkeulData.items
        items.append(item)
        return items
    }
}
