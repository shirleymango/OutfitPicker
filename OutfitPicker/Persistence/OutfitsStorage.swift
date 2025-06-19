//
//  OutfitsStorage.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

class OutfitsStorage {
    private let key = "outfits"
    
    func saveOutfits(_ outfits: [Outfit]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(outfits) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func loadOutfits() async throws -> [Outfit] {
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
    func topIDMatches(_ item: ClothingItem) -> Bool {
        return topID == item.id
    }

    func bottomIDMatches(_ item: ClothingItem) -> Bool {
        return bottomID == item.id
    }
}
