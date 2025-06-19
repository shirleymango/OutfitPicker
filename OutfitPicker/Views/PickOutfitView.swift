//
//  ContentView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/10/25.
//

import SwiftUI

struct PickOutfitView: View {
    let tops: [ClothingItem]
    let bottoms: [ClothingItem]
    @ObservedObject var outfitsViewModel: OutfitsViewModel

    @State private var selectedTopIndex = 0
    @State private var selectedBottomIndex = 0
    @State private var saveOutfitResult: SaveResult? = nil

    var selectedTop: ClothingItem? {
        tops.indices.contains(selectedTopIndex) ? tops[selectedTopIndex] : nil
    }

    var selectedBottom: ClothingItem? {
        bottoms.indices.contains(selectedBottomIndex) ? bottoms[selectedBottomIndex] : nil
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                VStack {
                    CarouselView(items: tops, selectedIndex: $selectedTopIndex)
                }

                VStack {
                    CarouselView(items: bottoms, selectedIndex: $selectedBottomIndex)
                }

                Button(action: {
                    guard let top = selectedTop, let bottom = selectedBottom else { return }

                    if let result = outfitsViewModel.addOutfit(top: top, bottom: bottom) {
                        withAnimation {
                            saveOutfitResult = result
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            saveOutfitResult = nil
                        }
                    }
                }) {
                    Text("Save Outfit to Closet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                if saveOutfitResult == .success {
                    Text("✅ Outfit Saved!")
                        .font(.headline)
                }
                if saveOutfitResult == .duplicate {
                    Text("⚠️ Outfit Already Saved!")
                        .font(.headline)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Outfit Picker")
        }
    }
}
