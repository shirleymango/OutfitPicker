//
//  GridView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import SwiftUI

struct GridView: View {
    let title: String
    let items: [ClothingItem]
    
    var body: some View {
        Text(title)
            .font(.headline)
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding()
                        .tag(index)
                }
            }
        }
    }
}
