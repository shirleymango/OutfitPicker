//
//  ClosetViewModel.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import Foundation
import SwiftUI

@MainActor
class ClosetViewModel: ObservableObject {
    @Published var closet: [ClothingItem] = []
    @Published var isLoading = true
    
    private let storage = ClosetStorage()
    private let outfitsStorage = OutfitsStorage() // used to prune outfits on delete
    private let outfitsViewModel: OutfitsViewModel
    
    init(outfitsViewModel: OutfitsViewModel) {
        self.outfitsViewModel = outfitsViewModel
    }
    
    func loadCloset() async {
        isLoading = true
        do {
            closet = await Task.detached { [self] in storage.load() }.value
            if closet.isEmpty {
                closet = SampleData.tops + SampleData.bottoms
                storage.save(closet)
            }
        } catch {
            closet = SampleData.tops + SampleData.bottoms
            storage.save(closet)
        }
        isLoading = false
    }
    
    func addImageFromCameraRoll(_ image: UIImage, type: ClothingItemType) {
        let fileName = UUID().uuidString + ".png"
        if let data = image.pngData() {
            let url = FileManager.default
                     .urls(for: .documentDirectory, in: .userDomainMask)[0]
                     .appendingPathComponent(fileName)
            try? data.write(to: url)

            let newItem = ClothingItem(imageName: fileName,
                                       itemType:  type,
                                       isFromCameraRoll: true)
            closet.append(newItem)
            storage.save(closet)
        }
    }
    
    func deleteItem(_ item: ClothingItem) async {
        closet.removeAll { $0.id == item.id }
        storage.save(closet)

        do {
            var outfits = try await outfitsStorage.loadOutfits()
            outfits.removeAll {
                $0.topIDMatches(item) || $0.bottomIDMatches(item)
            }
            outfitsStorage.saveOutfits(outfits)
            outfitsViewModel.setOutfits(outfits) // 🔥 Keep ViewModel in sync
        } catch {
            print("Failed to load outfits while deleting item: \(error)")
        }
    }
}
