//
//  Quake+Color.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 24.12.2024.
//

import SwiftUI

// An extension that adds a SwiftUI color property representing the quake's magnitude.

extension Quake {
    /// The color which corresponds with the quake's magnitude. Это цвет, который будет соотвествовать магнитуде землетресения
    var color: Color {
        switch magnitude {
        case 0..<1:
            return .green
        case 1..<2:
            return .yellow
        case 2..<3:
            return .orange
        case 3..<5:
            return .red
        case 5..<Double.greatestFiniteMagnitude:
            return .init(red: 0.8, green: 0.2, blue: 0.7)
        default:
            return .gray
        }
    }
}
