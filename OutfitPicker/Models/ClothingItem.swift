//
//  ClothingItem.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

enum ClothingItemType: CaseIterable {
    case shortSleeveTops, shorts, shortSkirts, longSleeveTops, longPants, longSkirts
        
    var stringValue: String {
        switch self {
        case .shorts: 
            return "Shorts"
        case .longPants:
            return "Long Pants"
        case .shortSleeveTops:
            return "Short Sleeve Tops"
        case .longSleeveTops:
            return "Long Sleeve Tops"
        case .longSkirts:
            return "Long Skirts"
        case .shortSkirts:
            return "Short Skirts"
        }
    }
}

struct ClothingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let itemType: ClothingItemType
}
