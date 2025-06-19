//
//  MainTabView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/16/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var outfitsViewModel = OutfitsViewModel()
    @StateObject private var closetViewModel: ClosetViewModel

    init() {
        let outfitsVM = OutfitsViewModel()
        _outfitsViewModel = StateObject(wrappedValue: outfitsVM)
        _closetViewModel = StateObject(wrappedValue: ClosetViewModel(outfitsViewModel: outfitsVM))
    }
    
    var body: some View {
        TabView {
            PickOutfitView(
                tops: closetViewModel.closet.filter { $0.itemType.isTop },
                bottoms: closetViewModel.closet.filter { $0.itemType.isBottom },
                outfitsViewModel: outfitsViewModel
            )
            .tabItem {
                Image(systemName: "tshirt")
                Text("Pick Outfit")
            }

            OutfitsView(
                tops: closetViewModel.closet.filter { $0.itemType.isTop },
                bottoms: closetViewModel.closet.filter { $0.itemType.isBottom },
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
        .task {
            await closetViewModel.loadCloset()
        }
    }
}
