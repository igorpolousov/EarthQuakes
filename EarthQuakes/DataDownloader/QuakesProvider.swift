//
//  QuakeProvider.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 21.01.2025.
//

import Foundation

class QaukesProvider: ObservableObject {
    
    @Published var quakes: [Quake] = []
    
    let client: QuakeClient
    
    func fetchQuakes() async throws {
        let latestQuakes =  try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuakes(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
