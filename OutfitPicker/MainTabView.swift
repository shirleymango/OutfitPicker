//
//  MainTabView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/16/25.
//

import SwiftUI

struct MainTabView: View {
    let tops = SampleData.tops
    let bottoms = SampleData.bottoms
    @StateObject private var outfitsViewModel = OutfitsViewModel()
    
    var body: some View {
        TabView {
            PickOutfitView(tops: tops, bottoms: bottoms, outfitsViewModel: outfitsViewModel)
                .tabItem {
                    Image(systemName: "tshirt")
                    Text("Pick Outfit")
                }
            
            OutfitsView(tops: tops, bottoms: bottoms, viewModel: outfitsViewModel)
                .tabItem {
                    Image(systemName: "hanger")
                    Text("Outfits")
                }
            ClosetView(tops: tops, bottoms: bottoms)
                .tabItem {
                    Image(systemName: "suitcase")
                    Text("Closet")
                }
        }
    }
}
