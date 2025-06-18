//
//  Closet.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import SwiftUI

struct ClosetView: View {
    @ObservedObject var viewModel: ClosetViewModel

    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?

    @State private var isDeleteMode = false
    @State private var itemToDelete: ClothingItem?
    @State private var showDeleteConfirmation = false

    var tops: [ClothingItem] {
        viewModel.closet.filter { $0.itemType.isTop }
    }

    var bottoms: [ClothingItem] {
        viewModel.closet.filter { $0.itemType.isBottom }
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Closet...")
                        .padding()
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            GridView(title: "Tops",
                                     items: tops,
                                     isDeleteMode: isDeleteMode,
                                     onDeleteTapped: { item in
                                itemToDelete = item
                                showDeleteConfirmation = true
                            })

                            GridView(title: "Bottoms",
                                     items: bottoms,
                                     isDeleteMode: isDeleteMode,
                                     onDeleteTapped: { item in
                                itemToDelete = item
                                showDeleteConfirmation = true
                            })
                        }
                        .padding(.top)
                        .onLongPressGesture {
                            withAnimation {
                                isDeleteMode.toggle()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Closet")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isDeleteMode {
                        Button("Done") {
                            withAnimation {
                                isDeleteMode = false
                            }
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Delete this item?", isPresented: $showDeleteConfirmation) {
                Button("Delete", role: .destructive) {
                    if let item = itemToDelete {
                        Task {
                            await viewModel.deleteItem(item)
                            itemToDelete = nil
                        }
                    }
                }
                Button("Cancel", role: .cancel) {
                    itemToDelete = nil
                }
            }
            .task {
                await viewModel.loadCloset()
            }
            .sheet(isPresented: $showImagePicker) {
                // Replace this with your image picker implementation
//                ImagePicker(selectedImage: $selectedImage) { image in
//                    if let image = image {
//                        viewModel.addImageFromCameraRoll(image)
//                    }
//                }
            }
        }
    }
}
