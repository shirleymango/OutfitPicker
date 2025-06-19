//
//  CarouselView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/10/25.
//

import SwiftUI

struct CarouselView: View {
    let items: [ClothingItem]
    @Binding var selectedIndex: Int
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $selectedIndex) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    if let image = item.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .tag(index)
                    } else {
                        Color.gray // fallback in case image fails
                            .cornerRadius(12)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            
            Text("\(selectedIndex + 1) / \(items.count)")
                .font(.caption.bold())
                .padding(8)
                .background(.thinMaterial)
                .clipShape(Capsule())
                .padding(.trailing, 12)
        }.frame(height: 250)
    }
}
