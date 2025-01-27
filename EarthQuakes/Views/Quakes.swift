//
//  Quakes.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 25.12.2024.
//

import SwiftUI

let staticData: [Quake] = [
    Quake(magnitude: 0.8,
          place: "Shakey Acres",
          time: Date(timeIntervalSinceNow: -1000),
          code: "nc73649170",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!,
          tsunami: 0),
    Quake(magnitude: 2.2,
          place: "Rumble Alley",
          time: Date(timeIntervalSinceNow: -5000),
          code: "hv72783692",
          detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/hv72783692")!,
          tsunami: 0)
    ]

struct Quakes: View {
    // Зачем это было использовано, что будет без этого wrapper
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    //@State var quakes = staticData //  Data for rows in List view
    @EnvironmentObject var provider: QaukesProvider
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection: Set<String> = []
    @State private var error: QuakeError?
    @State private var hasError = true
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(quakes) { quake in
                    QuakeRow(quake: quake)
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle(title) // See extension below
            .toolbar(content: toolbarContent) // Quakes+Toolbar
            .environment(\.editMode, $editMode) // Runs edit mode for rows
            .refreshable {
                 await fetchQuakes()
            }
        }
    }
}

// Functions
extension Quakes {
    
    // Navigation title setup depends of selction mode
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }

    // Используется для следующей функции
    func deleteQuakes(at offsets: IndexSet) {
        provider.deleteQuakes(atOffsets: offsets)
    }
    // Используется для работы во View
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    
    func fetchQuakes() async {
        isLoading = true
        do {
            try await provider.fetchQuakes()
            lastUpdated = Date().timeIntervalSince1970
        } catch {
            self.error = error as? QuakeError ?? .unexpectedError(error)
            self.hasError = true
        }
        
        isLoading = false
    }
}

//Preview
#Preview {
    Quakes()
}
