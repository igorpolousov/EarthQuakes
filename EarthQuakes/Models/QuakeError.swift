//
//  QuakeError.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 26.12.2024.
//

import Foundation

enum QuakeError: Error {
    case missingData
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found and will discard a quake missing a valid code, magnitude, place, or time.", comment: "")
        }
    }
}
