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
    
    func addOutfit(top: ClothingItem, bottom: ClothingItem) -> SaveResult? {
        if outfits.contains(where: { $0.topID == top.id && $0.bottomID == bottom.id }) {
            return .duplicate
        }
        let newOutfit = Outfit(top: top, bottom: bottom)
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
    
    func setOutfits(_ newOutfits: [Outfit]) {
        outfits = newOutfits
        storage.saveOutfits(outfits)
    }
}
