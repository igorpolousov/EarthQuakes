//
//  RefreshButton.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 26.12.2024.
//

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
    }
}

struct RefreshButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButton()
            .previewLayout(.sizeThatFits)
    }
}

//#Preview {
//    RefreshButton()
//}
