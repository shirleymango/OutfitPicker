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
    var isDeleteMode: Bool
    var onDeleteTapped: (ClothingItem) -> Void

    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal)

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
            ForEach(items) { item in
                ZStack(alignment: .topTrailing) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding()

                    if isDeleteMode {
                        Button(action: {
                            onDeleteTapped(item)
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .offset(x: 5, y: -5)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
