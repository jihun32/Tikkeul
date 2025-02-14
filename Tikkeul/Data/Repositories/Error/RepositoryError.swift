//
//  RepositoryError.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/13/25.
//

import Foundation

enum RepositoryError: Error {
    case missingRequiredProperty
    case itemNotFound
}
