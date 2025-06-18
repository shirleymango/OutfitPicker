//
//  Outfit.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

struct Outfit: Identifiable, Codable {
    let id: UUID
    let topIndex: Int
    let bottomIndex: Int
    
    init(topIndex: Int, bottomIndex: Int) {
        self.id = UUID()
        self.topIndex = topIndex
        self.bottomIndex = bottomIndex
    }
}
