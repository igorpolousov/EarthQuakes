//
//  QuakeDetailMap.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 12.02.2025.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
    }
}

#Preview {
    QuakeDetailMap()
}
