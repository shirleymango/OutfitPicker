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
        TabView(selection: $selectedIndex) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                if let image = item.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding()
                        .tag(index)
                } else {
                    Color.gray // fallback in case image fails
                        .cornerRadius(12)
                        .padding()
                        .tag(index)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
    }
}
