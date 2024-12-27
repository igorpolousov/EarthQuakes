//
//  EarthQuakesTests.swift
//  EarthQuakesTests
//
//  Created by Igor Polousov on 21.12.2024.
//

import XCTest
@testable import EarthQuakes

final class EarthQuakesTests: XCTestCase {

    func testGeoJSONDecoderDecodesTest() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970 // step 13
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        XCTAssertEqual(quake.code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000 // see comments below
        /*
         GeoJSON format stores the time of the quake as “milliseconds since the epoch.” A TimeInterval represents a number of seconds. So, you divide the time interval by 1000 to make sure that you compare the same units.
         */
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
        
        XCTAssertEqual(quake.tsunami, 0)
        
    }

}
