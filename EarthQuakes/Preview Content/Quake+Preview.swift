//
//  Quake+Preview.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 30.01.2025.
//

import Foundation

extension Quake {
    static var preview: Quake {
        let quake = Quake(magnitude: 0.34,
                               place: "Shakey Acres",
                               time: Date(timeIntervalSinceNow: -1000),
                               code: "nc73649170",
                          detail: URL(string: "https://example.com")!,
                          tsunami: 0)
             return quake
    }
}
