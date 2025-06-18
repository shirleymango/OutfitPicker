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
    @Published var closet: [Outfit] = []
    @Published var isLoading = true
    
    private let storage = OutfitsStorage()
    
    func loadCloset() async {
        do {
            let loadedCloset = try await storage.loadCloset()
            closet = loadedCloset
        }
        catch {
            print("Failed to load closet:", error)
            closet = []  // fallback gracefully
        }
        isLoading = false
    }
    
    func addOutfit(topIndex: Int, bottomIndex: Int) -> SaveResult? {
        if closet.contains(where: {$0.topIndex == topIndex && $0.bottomIndex == bottomIndex}) {
            return .duplicate
        }
        let newOutfit = Outfit(topIndex: topIndex, bottomIndex: bottomIndex)
        closet.append(newOutfit)
        storage.saveCloset(closet)
        return .success
    }
    
    func deleteOutfit(at offsets: IndexSet) {
        closet.remove(atOffsets: offsets)
        storage.saveCloset(closet)
    }
    
    func deleteOutfit(_ outfit: Outfit) {
        closet.removeAll { $0.id == outfit.id }
        storage.saveCloset(closet)
    }
}
