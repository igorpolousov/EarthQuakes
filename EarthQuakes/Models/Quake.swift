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
    ///  Предупреждение о цунами
    let tsunami: Int
    var location: QuakeLocation?
}

extension Quake: Identifiable {
    var id: String {code} // как еще можно использовать такой указатель типа переменной?
}

extension Quake: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case place
        case time
        case code
        case detail
        case tsunami
    }
    
    init(from decoder: any Decoder) throws {
        // code below was provided by Apple's tutorial
        //        let container = try decoder.container(keyedBy: CodingKeys.self)
        //        self.magnitude = try container.decode(Double.self, forKey: .magnitude)
        //        self.place = try container.decode(String.self, forKey: .place)
        //        self.time = try container.decode(Date.self, forKey: .time)
        //        self.code = try container.decode(String.self, forKey: .code)
        //        self.detail = try container.decode(URL.self, forKey: .detail)
        
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawMagnitude = try? values.decode(Double.self, forKey: .magnitude)
        let rawPlace = try? values.decode(String.self, forKey: .place)
        let rawTime = try? values.decode(Date.self, forKey: .time)
        let rawCode = try? values.decode(String.self, forKey: .code)
        let rawDetail = try? values.decode(URL.self, forKey: .detail)
        let rawTsunami = try? values.decode(Int.self, forKey: .tsunami)
        
        guard let magnitude = rawMagnitude,
              let place = rawPlace,
              let time = rawTime,
              let code = rawCode,
              let detail = rawDetail,
              let tsunami = rawTsunami
        else {
            throw QuakeError.missingData
        }
        
        self.magnitude = magnitude
        self.place = place
        self.time = time
        self.code = code
        self.detail = detail
        self.tsunami = tsunami
    }
}
