//
//  QuakeClient.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 11.01.2025.
//

import Foundation

class QuakeClient {
    
    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            return allQuakes.quakes
        }
    }
    
    private lazy var decoder: JSONDecoder = {
        let adecoder = JSONDecoder()
        adecoder.dateDecodingStrategy = .millisecondsSince1970
        return adecoder
    }()
    
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
