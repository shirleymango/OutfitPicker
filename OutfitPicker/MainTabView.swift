//
//  MainTabView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/16/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var outfitsViewModel = OutfitsViewModel()
    @StateObject private var closetViewModel = ClosetViewModel()
    @State private var clothingItems: [ClothingItem] = []
    
    let closetStorage = ClosetStorage()
    
    var body: some View {
        TabView {
            PickOutfitView(
                tops: clothingItems.filter {$0.itemType.isTop},
                bottoms: clothingItems.filter {$0.itemType.isBottom},
                outfitsViewModel: outfitsViewModel)
            .tabItem {
                Image(systemName: "tshirt")
                Text("Pick Outfit")
            }
            
            OutfitsView(
                tops: clothingItems.filter { $0.itemType.isTop },
                bottoms: clothingItems.filter { $0.itemType.isBottom },
                viewModel: outfitsViewModel
            )
            .tabItem {
                Image(systemName: "hanger")
                Text("Outfits")
            }
            ClosetView(viewModel: closetViewModel)
            .tabItem {
                Image(systemName: "suitcase")
                Text("Closet")
            }
        }
        .onAppear {
            clothingItems = closetStorage.load()
        }
    }
}
