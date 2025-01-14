//
//  EarthQuakesTests.swift
//  EarthQuakesTests
//
//  Created by Igor Polousov on 21.12.2024.
//

import XCTest
@testable import EarthQuakes

final class EarthQuakesTests: XCTestCase {

    // Тестирование структуры Quake
    func testGeoJSONDecoderDecodesTest() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970 // step 13
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000 // see comments below
        /*
         GeoJSON format stores the time of the quake as “milliseconds since the epoch.” A TimeInterval represents a number of seconds. So, you divide the time interval by 1000 to make sure that you compare the same units.
         */
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
        XCTAssertEqual(quake.tsunami, 0)
        XCTAssertEqual(quake.magnitude, 0.34)
        XCTAssertEqual(quake.place, "5km NW of The Geysers, CA")
        XCTAssertEqual(quake.code, "73649170")
        
        let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")
        
        XCTAssertEqual(quake.detail, url)
        
    }
    
    // Тестирование струтуры GeoJSON
    func testGeoJSONdecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decoded = try decoder.decode(GeoJSON.self, from: testQuakeData)
        
        XCTAssertEqual(decoded.quakes.count, 6)
        XCTAssertEqual(decoded.quakes[0].code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = decoded.quakes[0].time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    // Тестирование получения долготы и широты
    func testQuakeLocationDecoding() throws {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(QuakeLocation.self, from: testDetail_hv72783692)
        XCTAssertEqual(decodedData.latitude,19.2189998626709, accuracy: 0.00000000001)
        XCTAssertEqual(decodedData.longitude,-155.434173583984, accuracy: 0.00000000001)
    }
    
    // Тестирование HttpDownloaderClient
    func testClientDoesFetchEarthQuakesData() async throws {
        let downloader = TestDownloader()
        let client = QuakeClient(downloader: downloader)
        
        let quakes = try await client.quakes
        
        XCTAssertEqual(quakes.count, 6)
        
    }

}
