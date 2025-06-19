//
//  Outfit.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

struct Outfit: Identifiable, Codable {
    let id = UUID()
    let topID: UUID
    let bottomID: UUID

    init(top: ClothingItem, bottom: ClothingItem) {
        self.topID = top.id
        self.bottomID = bottom.id
    }
}
