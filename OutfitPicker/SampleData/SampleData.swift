//
//  SampleData.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/10/25.
//

import Foundation

struct SampleData {
    static let tops: [ClothingItem] = {
        (1...20).map { ClothingItem(imageName: "top\($0)", itemType: .shortSleeveTops, isFromCameraRoll: false) }
    }()
    static let bottoms: [ClothingItem] = [
        ClothingItem(imageName: "bottom1", itemType: .longPants, isFromCameraRoll: false),
        ClothingItem(imageName: "bottom2", itemType: .longPants, isFromCameraRoll: false),
        ClothingItem(imageName: "bottom3", itemType: .longPants, isFromCameraRoll: false),
        ClothingItem(imageName: "bottom4", itemType: .longPants, isFromCameraRoll: false),
        ClothingItem(imageName: "bottom5", itemType: .longSkirts, isFromCameraRoll: false),
        ClothingItem(imageName: "bottom6", itemType: .shortSkirts, isFromCameraRoll: false),
        ClothingItem(imageName: "bottom7", itemType: .shorts, isFromCameraRoll: false),
        ClothingItem(imageName: "bottom8", itemType: .shortSkirts, isFromCameraRoll: false)
    ]
}
