//
//  ClothingItemType.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import Foundation

enum ClothingItemType: CaseIterable, Codable {
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

extension ClothingItemType {
    var isTop: Bool {
        [.shortSleeveTops, .longSleeveTops].contains(self)
    }

    var isBottom: Bool {
        [.shorts, .shortSkirts, .longPants, .longSkirts].contains(self)
    }
}

