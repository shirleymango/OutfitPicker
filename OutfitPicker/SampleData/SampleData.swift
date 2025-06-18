//
//  SampleData.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/10/25.
//

import Foundation

struct SampleData {
    static let tops: [ClothingItem] = {
        (1...20).map { ClothingItem(imageName: "top\($0)", itemType: .shortSleeveTops) }
    }()
    static let bottoms: [ClothingItem] = [
        ClothingItem(imageName: "bottom1", itemType: .longPants),
        ClothingItem(imageName: "bottom2", itemType: .longPants),
        ClothingItem(imageName: "bottom3", itemType: .longPants),
        ClothingItem(imageName: "bottom4", itemType: .longPants),
        ClothingItem(imageName: "bottom5", itemType: .longSkirts),
        ClothingItem(imageName: "bottom6", itemType: .shortSkirts),
        ClothingItem(imageName: "bottom7", itemType: .shorts),
        ClothingItem(imageName: "bottom8", itemType: .shortSkirts)
    ]
}
