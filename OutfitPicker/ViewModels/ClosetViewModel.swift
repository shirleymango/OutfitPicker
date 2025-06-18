//
//  ClosetViewModel.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import Foundation

@MainActor
class ClosetViewModel: ObservableObject {
    @Published var closet: [ClothingItem] = []
    @Published var isLoading = true
    
    private let storage = ClosetStorage()
    private let outfitsStorage = OutfitsStorage() // used to prune outfits on delete
    
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
    
    func deleteItem(_ item: ClothingItem) async {
        closet.removeAll { $0.id == item.id }
        storage.save(closet)

        do {
            var outfits = try await outfitsStorage.loadCloset()
            outfits.removeAll {
                $0.topIndexMatches(item: item, in: closet) ||
                $0.bottomIndexMatches(item: item, in: closet)
            }
            outfitsStorage.saveCloset(outfits)
        } catch {
            print("Failed to load outfits while deleting item: \(error)")
        }
    }
}
