//
//  ClothingItem.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation
import SwiftUI

struct ClothingItem: Identifiable, Codable {
    let id: UUID
    let imageName: String?    // For saved image files
    let itemType: ClothingItemType
    let isFromCameraRoll: Bool  // Flag to distinguish source

    init(imageName: String?, itemType: ClothingItemType, isFromCameraRoll: Bool) {
        self.id = UUID()
        self.imageName = imageName
        self.itemType = itemType
        self.isFromCameraRoll = isFromCameraRoll
    }

    // Load image (from asset or disk)
    var image: Image? {
        if isFromCameraRoll, let imageName = imageName {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
            if let uiImage = UIImage(contentsOfFile: url.path) {
                return Image(uiImage: uiImage)
            }
        }
        if let imageName = imageName {
            return Image(imageName) // from asset catalog
        }
        return nil
    }
}

