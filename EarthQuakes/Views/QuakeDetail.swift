//
//  QuakeDetail.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 30.01.2025.
//

import SwiftUI

struct QuakeDetail: View {

    var quake: Quake
    
    @EnvironmentObject private var quakesProvider: QaukesProvider
    @State private var location: QuakeLocation? = nil
    
    @State private var onTapLongLatt: Bool = true
    
    var body: some View {
        VStack {
            if let location = self.location { // if location {}
                QuakeDetailMap(location: location, tintColor: quake.color).ignoresSafeArea(.container)
            }
            
            QuakeMagnitude(quake: quake)
            
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted())")
                .foregroundStyle(Color.secondary)
            
            if let location = self.location {
                // Вариант 1
                VStack {
                    Text(!onTapLongLatt ? "Longitude: \(location.latitude)" : "Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))" )
                    
                    Text(!onTapLongLatt ? "Longitude: \(location.longitude)" : "Latitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))" )
                }
                .onTapGesture {
                    onTapLongLatt.toggle()
                }
                
                // Вариант 3( просто сокращенные long and latt)
//                if let location = quake.location {
//                        Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))" )
//
//                        Text("Latitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))" )
//                    }

//                
                //Вариант 2
//                if onTapLongLatt == true {
//                    VStack {
//                        Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
//                        
//                        Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
//                    }
//                    .onTapGesture {
//                        onTapLongLatt.toggle()
//                    }
//                } else {
//                    VStack {
//                        Text("Latitude: \(location.latitude)")
//                        
//                        Text("Longitude: \(location.longitude)")
//                          
//                    }
//                    .onTapGesture {
//                        onTapLongLatt.toggle()
//                    }
//                       
//                }
            }
        }
        .task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakesProvider.location(for: quake)
                }
            }
        }
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
}
