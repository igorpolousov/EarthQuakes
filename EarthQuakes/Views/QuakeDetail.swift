//
//  QuakeDetail.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 30.01.2025.
//

import SwiftUI

struct QuakeDetail: View {
    
    var quake: Quake
    var body: some View {
        VStack {
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted())")
                .foregroundStyle(Color.secondary)
            
            if let location = quake.location {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            }
        }
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
}
