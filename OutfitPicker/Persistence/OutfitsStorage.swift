//
//  ClosetStorage.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

class OutfitsStorage {
    private let key = "closet"
    
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
