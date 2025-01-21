//
//  EarthQuakesApp.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 21.12.2024.
//

import SwiftUI

@main
struct EarthQuakesApp: App {
    
    @StateObject var quakesProvider: QaukesProvider = QaukesProvider()
    
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakesProvider)
        }
    }
}
