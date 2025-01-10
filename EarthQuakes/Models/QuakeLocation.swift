//
//  QuakeLocation.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 28.12.2024.
//

import Foundation

/// Struct  for decoding Quake Location
struct QuakeLocation: Decodable {
    
    var latitude: Double { properties.products.origin.first!.properties.latitude}
    var longitude: Double { properties.products.origin.first!.properties.longitude}
    
    private var properties: RootProperties
    
    struct RootProperties: Decodable {
        var products: Products
    }
    
    struct Products: Decodable {
        var origin: [Origin]
    }
    
    struct Origin: Decodable {
        var properties: OriginProperties
    }
    
    struct OriginProperties {
        var longitude: Double
        var latitude: Double
    }
}

extension QuakeLocation.OriginProperties: Decodable {
    private enum OriginPropertiesCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OriginPropertiesCodingKeys.self)
        let longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        let latitude = (try container.decodeIfPresent(String.self, forKey: .latitude))
        
        guard let longitude = Double(longitude!),
              let latitude = Double(latitude!)  else {
            throw QuakeError.missingData
        }
        
        self.latitude = latitude
        self.longitude = longitude
    }
}
