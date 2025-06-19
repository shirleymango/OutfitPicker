//
//  ClosetViewModel.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import Foundation

enum SaveResult {
    case success, duplicate
}

@MainActor
class OutfitsViewModel: ObservableObject {
    @Published var outfits: [Outfit] = []
    @Published var isLoading = true
    
    private let storage = OutfitsStorage()
    
    func loadOutfits() async {
        do {
            let loadedOutfits = try await storage.loadOutfits()
            outfits = loadedOutfits
        }
        catch {
            print("Failed to load outfits:", error)
            outfits = []  // fallback gracefully
        }
        isLoading = false
    }
    
    func addOutfit(topIndex: Int, bottomIndex: Int) -> SaveResult? {
        if outfits.contains(where: {$0.topIndex == topIndex && $0.bottomIndex == bottomIndex}) {
            return .duplicate
        }
        let newOutfit = Outfit(topIndex: topIndex, bottomIndex: bottomIndex)
        outfits.append(newOutfit)
        storage.saveOutfits(outfits)
        return .success
    }
    
    func deleteOutfit(at offsets: IndexSet) {
        outfits.remove(atOffsets: offsets)
        storage.saveOutfits(outfits)
    }
    
    func deleteOutfit(_ outfit: Outfit) {
        outfits.removeAll { $0.id == outfit.id }
        storage.saveOutfits(outfits)
    }
}
