//
//  Closet.swift
//  OutfitPicker
//
//  Created by ZhuMacPro on 6/18/25.
//

import SwiftUI
import PhotosUI

struct ClosetView: View {
    @ObservedObject var viewModel: ClosetViewModel

    @State private var selectedItem: PhotosPickerItem? = nil          // the raw PhotosPicker result
    @State private var pendingImage:  UIImage?        = nil          // image waiting for a type
    @State private var showTypePicker = false                         // shows confirmationDialog

    @State private var isDeleteMode        = false
    @State private var itemToDelete:       ClothingItem?
    @State private var showDeleteAlert     = false

    var tops:    [ClothingItem] { viewModel.closet.filter { $0.itemType.isTop    } }
    var bottoms: [ClothingItem] { viewModel.closet.filter { $0.itemType.isBottom } }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Closet…").padding()
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            GridView(title: "Tops",
                                     items: tops,
                                     isDeleteMode: isDeleteMode) { item in
                                itemToDelete = item
                                showDeleteAlert = true
                            }

                            GridView(title: "Bottoms",
                                     items: bottoms,
                                     isDeleteMode: isDeleteMode) { item in
                                itemToDelete = item
                                showDeleteAlert = true
                            }
                        }
                        .padding(.top)
                        .onLongPressGesture { withAnimation { isDeleteMode.toggle() } }
                    }
                }
            }
            .navigationTitle("Closet")
            .toolbar {
                // ➋ PhotosPicker is the button itself – instant presentation
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $selectedItem,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        Image(systemName: "plus")
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    if isDeleteMode {
                        Button("Done") { withAnimation { isDeleteMode = false } }
                    }
                }
            }
            // ➌ Handle the picked photo
            .onChange(of: selectedItem) { newItem in
                guard let newItem else { return }
                Task {
                    if let data  = try? await newItem.loadTransferable(type: Data.self),
                       let uiImg = UIImage(data: data) {
                        pendingImage = uiImg
                        showTypePicker = true            // trigger type selection
                    }
                    selectedItem = nil                  // reset picker binding
                }
            }
            // ➍ Ask the user which clothing-type to assign
            .confirmationDialog("Choose item type",
                                isPresented: $showTypePicker,
                                titleVisibility: .visible) {
                ForEach(ClothingItemType.allCases, id: \.self) { type in
                    Button(type.stringValue) {
                        if let img = pendingImage {
                            viewModel.addImageFromCameraRoll(img, type: type)
                        }
                        pendingImage = nil
                    }
                }
                Button("Cancel", role: .cancel) { pendingImage = nil }
            }
            // delete confirmation (unchanged)
            .alert("Delete this item?",
                   isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let item = itemToDelete {
                        Task { await viewModel.deleteItem(item) }
                    }
                    itemToDelete = nil
                }
                Button("Cancel", role: .cancel) { itemToDelete = nil }
            }
            .task { await viewModel.loadCloset() }
        }
    }
}
