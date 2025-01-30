//
//  QuakeClient.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 11.01.2025.
//

import Foundation

actor QuakeClient {
    
    private let quakeCashe: NSCache<NSString, CashEntryObject> = NSCache()
    
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
    
    func quakeLocation(from url: URL) async throws -> QuakeLocation {
        
        if let cashed = quakeCashe[url] {
            switch cashed {
            case .ready(let location) :
                return location
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task<QuakeLocation, Error> {
            let data = try await downloader.httpData(from: url)
            let location = try decoder.decode(QuakeLocation.self, from: data)
            return location
        }
        quakeCashe[url] = .inProgress(task)
        do {
            let location = try await task.value
            quakeCashe[url] = .ready(location)
            return location
        } catch {
            quakeCashe[url] = nil
            throw error
        }
        
    }
  
}
