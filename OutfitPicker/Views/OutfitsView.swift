//
//  ClosetView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/11/25.
//

import SwiftUI

struct OutfitsView: View {
    let tops: [ClothingItem]
    let bottoms: [ClothingItem]
    @ObservedObject var viewModel: OutfitsViewModel
    
    @State private var selectedTypes: Set<ClothingItemType> = []
    
    var filteredCloset: [Outfit] {
        if selectedTypes.isEmpty {
            return viewModel.outfits
        }
        
        return viewModel.outfits.filter { outfit in
            let top = tops.first { $0.id == outfit.topID }
            let bottom = bottoms.first { $0.id == outfit.bottomID }
            
            let topMatches = top.map { selectedTypes.contains($0.itemType) } ?? false
            let bottomMatches = bottom.map { selectedTypes.contains($0.itemType) } ?? false
            
            return topMatches || bottomMatches
        }
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Outfits...")
            } else {
                VStack {
                    Text("Your Outfits")
                        .font(.largeTitle)
                        .padding()
                    
                    MultiSelectFilterView(title: "Filter by Item Type",
                                          options: ClothingItemType.allCases,
                                          selected: $selectedTypes)
                    if filteredCloset.isEmpty {
                        if selectedTypes.isEmpty {
                            Text("No outfits in the closet yet.")
                                .foregroundColor(.secondary)
                        } else {
                            Text("No outfits with selected filter(s).")
                                .foregroundColor(.secondary)
                        }
                    } else {
                        List {
                            ForEach(filteredCloset) { outfit in
                                HStack {
                                    Group {
                                        if let top = tops.first(where: { $0.id == outfit.topID }) {
                                            OutfitImageView(for: top)
                                        }
                                        
                                        if let bottom = bottoms.first(where: { $0.id == outfit.bottomID }) {
                                            OutfitImageView(for: bottom)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        viewModel.deleteOutfit(outfit)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                            .onDelete(perform: viewModel.deleteOutfit)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.loadOutfits()
        }
    }
}

@ViewBuilder
func OutfitImageView(for item: ClothingItem) -> some View {
    if let image = item.image {
        image
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .cornerRadius(8)
    } else {
        Color.gray
            .scaledToFit()
            .frame(height: 100)
            .cornerRadius(8)
    }
}
