//
//  QuakeDetailMap.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 12.02.2025.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    
    let location: QuakeLocation
    let tintColor: Color
    let place: QuakePlace
    
    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.place = QuakePlace(location: location)
    }
    
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [place]) { place in
            MapMarker(coordinate: place.location, tint: tintColor)
        }
            .onAppear {
                withAnimation {
                    region.center = place.location
                    region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                }
            }
    }
}


struct QuakePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), location: QuakeLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}

