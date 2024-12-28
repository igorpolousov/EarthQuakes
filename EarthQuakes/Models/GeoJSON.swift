//
//  GeoJSON.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 28.12.2024.
//

import Foundation

/// Structure for decoding GeoJSON  root object
struct GeoJSON: Decodable {
    
    /// Root GeoJSON container
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    
    /// Features container from GeoJSON
    private enum FeaturesCodingKeys: String, CodingKey {
        case properties
    }
    
    /// Array of Quake objects in GeoJSON struct
    private(set) var quakes: [Quake] = [] // private(set) - в других местах будет недоступно изменение quakes и будет доступно чтение.
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featuresContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featuresContainer.isAtEnd {
            let propertiesContainer = try featuresContainer.nestedContainer(keyedBy: FeaturesCodingKeys.self)
            // Возможно в качестве названия переменной более подошло бы quake instead of properties
            if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) { // Optional try? будет пропускать объекты, которые не удалось дкодировать
                quakes.append(properties)
            }
        }
    }
    
}
