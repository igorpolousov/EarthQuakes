//
//  Quake.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 24.12.2024.
//

import Foundation

/// Sturcture for representing quake data
struct Quake {
    ///  Магнитуда землетрясения свойство struct Quake
    let magnitude: Double
    ///  Место землетрясения свойство struct Quake
    let place: String
    ///  Дата и время землетрясения свойство struct Quake
    let time: Date
    ///  Код землетрясения ( что это такое на старте не понятно) свойство struct Quake
    let code: String
    ///  Ссылка на детали землетрясения свойство struct Quake
    let detail: URL
}

extension Quake: Identifiable {
    var id: String {code} // как еще можно использовать такой указатель типа переменной?
}
