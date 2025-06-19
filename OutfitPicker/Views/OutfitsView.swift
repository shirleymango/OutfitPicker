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
            let topType = tops[outfit.topIndex].itemType
            let bottomType = bottoms[outfit.bottomIndex].itemType
            return selectedTypes.contains(topType) || selectedTypes.contains(bottomType)
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
                                    Image(tops[outfit.topIndex].imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .cornerRadius(8)
                                    
                                    Image(bottoms[outfit.bottomIndex].imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .cornerRadius(8)
                                    
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
