//
//  MultiSelectFilterView.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/16/25.
//

import Foundation
import SwiftUI

struct MultiSelectFilterView: View {
    let title: String
    let options: [ClothingItemType]
    @Binding var selected: Set<ClothingItemType>
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                ForEach(options, id: \.self) { item in
                    Button(action: {
                        if selected.contains(item) {
                            selected.remove(item)
                        } else {
                            selected.insert(item)
                        }
                    }) {
                        Text(item.stringValue)
                            .font(.subheadline)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(selected.contains(item) ? Color.blue : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
}
