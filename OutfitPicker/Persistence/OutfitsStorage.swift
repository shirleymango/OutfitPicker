//
//  ClosetStorage.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

class OutfitsStorage {
    private let key = "outfits"
    
    func saveCloset(_ closet: [Outfit]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(closet) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func loadCloset() async throws -> [Outfit] {
        guard let savedData = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        let decoded = try await Task.detached(priority: .userInitiated) {
            return try JSONDecoder().decode([Outfit].self, from: savedData)
        }.value
        
        return decoded
    }
}

extension Outfit {
    func topIndexMatches(item: ClothingItem, in closet: [ClothingItem]) -> Bool {
        guard let top = closet.indices.contains(topIndex) ? closet[topIndex] : nil else { return false }
        return top.id == item.id
    }
    
    func bottomIndexMatches(item: ClothingItem, in closet: [ClothingItem]) -> Bool {
        guard let bottom = closet.indices.contains(bottomIndex) ? closet[bottomIndex] : nil else { return false }
        return bottom.id == item.id
    }
}
