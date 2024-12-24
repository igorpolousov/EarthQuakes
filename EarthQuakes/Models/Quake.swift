//
//  Quake.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 24.12.2024.
//

import Foundation

// Sturcture for representing quake data

struct Quake {
    let magnitude: Double
    let place: String
    let time: Date
    let code: String
    let detail: URL
}
extension Quake: Identifiable {
    var id: String {code}
}
