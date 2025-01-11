//
//  HTTPDataDownloader.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 11.01.2025.
//

import Foundation

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}


extension URLSession: HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data {
        <#code#>
    }
    
}
