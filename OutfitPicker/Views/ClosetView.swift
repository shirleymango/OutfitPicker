//
//  Closet.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import SwiftUI

struct ClosetView: View {
    let tops: [ClothingItem]
    let bottoms: [ClothingItem]
    
    var body: some View {
        VStack {
            Text("Your Closet")
                .font(.largeTitle)
                .padding()
            GridView(title: "Tops", items: tops)
            GridView(title: "Bottoms", items: bottoms)
        }
    }
}
