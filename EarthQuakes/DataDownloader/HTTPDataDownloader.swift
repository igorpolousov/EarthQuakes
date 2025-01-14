//
//  HTTPDataDownloader.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 11.01.2025.
//

import Foundation

let validStatus = 200...299

protocol HTTPDataDownloader {
    /// A protocol describing an HTTP Data Downloader.
    func httpData(from: URL) async throws -> Data
}


extension URLSession: HTTPDataDownloader {
    
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw QuakeError.networkError
        }
        return data
    }
    
}

