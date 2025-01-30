//
//  CashEntryObject.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 30.01.2025.
//

import Foundation

final class CashEntryObject {
    
    let entry: CashEntry
    init(entry: CashEntry) {
        self.entry = entry
    }
}

enum CashEntry {
    case inProgress(Task<QuakeLocation,Error>)
    case ready(QuakeLocation)
}
