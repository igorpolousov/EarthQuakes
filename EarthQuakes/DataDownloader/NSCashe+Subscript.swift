//
//  NSCashe+Subscript.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 30.01.2025.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CashEntryObject {
    subscript(_ url: URL) -> CashEntry? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = CashEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
