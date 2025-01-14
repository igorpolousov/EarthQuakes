//
//  TestDownloader.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 14.01.2025.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    
    func httpData(from: URL) async throws -> Data {
       // fatalError("unimplemented") - применение этой строки не будет показывать ошибку компилятора пока не написан код функции
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testQuakeData
    }
    
}
