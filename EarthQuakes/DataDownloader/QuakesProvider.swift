//
//  QuakeProvider.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 21.01.2025.
//

import Foundation

class QaukesProvider: ObservableObject {
    @Published var quakes: [Quake] = []
}
