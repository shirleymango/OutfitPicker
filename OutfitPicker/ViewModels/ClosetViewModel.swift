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
            try await Task.sleep(nanoseconds: 200 * 1_000_000) // Simulated delay
            closet = storage.load()
        } catch {
            closet = []
        }
        isLoading = false
    }
    
    func addItem(_ item: ClothingItem) {
        closet.append(item)
        storage.save(closet)
    }
    
    func addImageFromCameraRoll(_ image: UIImage) {
        let imageName = UUID().uuidString + ".png"
        
        if let data = image.pngData() {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
            try? data.write(to: url)

            let newItem = ClothingItem(imageName: imageName, itemType: .shortSleeveTops, isFromCameraRoll: true)
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
