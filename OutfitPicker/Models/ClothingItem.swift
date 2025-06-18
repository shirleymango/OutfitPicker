//
//  ClothingItem.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

struct ClothingItem: Identifiable, Codable {
    let id: UUID
    let imageName: String
    let itemType: ClothingItemType
    
    init(imageName: String, itemType: ClothingItemType) {
        self.id = UUID()
        self.imageName = imageName
        self.itemType = itemType
    }
}
