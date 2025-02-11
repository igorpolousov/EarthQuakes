//
//  QuakeDetail.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 30.01.2025.
//

import SwiftUI

struct QuakeDetail: View {
    
    var quake: Quake
    @State private var onTapLongLatt: Bool = true
    var body: some View {
        VStack {
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted())")
                .foregroundStyle(Color.secondary)
            
            if let location = quake.location {
                // Вариант 1
                VStack {
                    Text(!onTapLongLatt ? "Longitude: \(location.latitude)" : "Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))" )
                    
                    Text(!onTapLongLatt ? "Longitude: \(location.longitude)" : "Latitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))" )
                }
                .onTapGesture {
                    onTapLongLatt.toggle()
                }
                
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
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
}
