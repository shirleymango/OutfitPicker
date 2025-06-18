//
//  ClosetStorage.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import Foundation

class ClosetStorage {
    private let key = "closet"
    
    func save(_ items: [ClothingItem]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save closet:", error)
        }
    }
    
    func load() -> [ClothingItem] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([ClothingItem].self, from: data)
        } catch {
            print("Failed to decode closet:", error)
            return []
        }
    }
}
