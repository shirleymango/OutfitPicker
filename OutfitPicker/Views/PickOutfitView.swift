//
//  ContentView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/10/25.
//

import SwiftUI

struct PickOutfitView: View {
    let tops:    [ClothingItem]
    let bottoms: [ClothingItem]
    @ObservedObject var outfitsViewModel: OutfitsViewModel

    @State private var selectedTopIndex     = 0
    @State private var selectedBottomIndex  = 0
    @State private var saveResult: SaveResult? = nil

    private var selectedTop   : ClothingItem? { tops[safe: selectedTopIndex]    }
    private var selectedBottom: ClothingItem? { bottoms[safe: selectedBottomIndex] }

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                CarouselView(items: tops,    selectedIndex: $selectedTopIndex)
                CarouselView(items: bottoms, selectedIndex: $selectedBottomIndex)
            }
            .navigationTitle("Pick Outfit")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Save Outfit") {
                        guard let top = selectedTop, let bottom = selectedBottom else { return }
                        if let result = outfitsViewModel.addOutfit(top: top, bottom: bottom) {
                            withAnimation { saveResult = result }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { saveResult = nil }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .overlay(alignment: .top) {
                if let result = saveResult {
                    Text(result == .success ? "✅ Outfit Saved!" : "⚠️ Already Saved")
                        .font(.callout.bold())
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(.thinMaterial)
                        .clipShape(Capsule())
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.top, 8)
                }
            }
        }
    }
}

// Convenience safe-subscript to avoid out-of-range crashes
private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

