# Outfit Picker

Outfit Picker is a SwiftUI app that helps you plan your outfits by mixing-and-matching tops & bottoms and saving complete outfits.

<div align="center">
  <img src="https://github.com/user-attachments/assets/bfa9fdc5-5a3f-47a0-b66a-432b6c14d73e" alt="drawing" width="400"/>
</div>

---

## I. Features

| ✓ | Description |
|---|-------------|
| **Pick outfits** | Two swipe-able carousels (Top / Bottom) preview every combination. |
| **Save outfits** | “Save Outfit” stores a unique pair. Duplicate detection prevents clutter. |
| **My Closet** | Grid view of every clothing item, grouped by Tops & Bottoms. Long-press background to enter **delete-mode** (minus icons, Home-Screen style). |
| **Add clothing** | Tap **“+”** → **PhotosPicker** opens instantly → pick a photo → choose an item-type → item saved to Documents with a UUID filename. |
| **Reactive MVVM** | `ClosetViewModel` & `OutfitsViewModel` keep UI and persistence in sync via `@Published`, `@MainActor`, and background loading. |
| **Persistence**  | Lightweight `Codable` structs + `UserDefaults` for quick demos (swap for Core Data later). |

---

## II. Project Structure

The app is organized using an MVVM architecture:

### Models
- `ClothingItem.swift` – Represents a clothing item with type, ID, and image data.
- `Outfit.swift` – Represents an outfit, storing IDs for top and bottom clothing items.

### Storage
- `ClosetStorage.swift` – Saves and loads the closet (array of `ClothingItem`) to disk using `UserDefaults`.
- `OutfitsStorage.swift` – Saves and loads outfits (array of `Outfit`) to disk using `UserDefaults`.

### ViewModels
- `ClosetViewModel.swift` – Handles logic for adding/removing clothing items and syncing changes with outfits.
- `OutfitsViewModel.swift` – Handles logic for adding/removing outfits and loading them from disk.

### Views
- `MainTabView.swift` – Root tab navigation for Pick, Closet, and Outfits tabs.
- `PickOutfitView.swift` – Lets user pick a top and bottom, then save an outfit.
- `ClosetView.swift` – Displays all clothing items, manages photo picking and delete mode.
- `OutfitsView.swift` – Displays saved outfits with support for filtering and deleting.

### Components
- `CarouselView.swift` – Horizontal image selector for picking tops/bottoms.
- `GridView.swift` – Reusable grid layout for displaying clothing items.

## III. Getting Started

### Requirements
- Xcode 15 or later  
- iOS 16+ deployment target (uses `PhotosPicker`)  
- Swift 5.9  

### Clone & Run
```bash
git clone https://github.com/your-username/OutfitPicker.git
open OutfitPicker/OutfitPicker.xcodeproj
```
1. **Build & run** on a simulator or device.
2. **Grant Photo Library permission** when prompted.
3. Tap **“➕”** in the **Closet** tab → pick a photo → choose item type → it appears in the grid.
4. Swipe through carousels in **Pick Outfit**, then tap **Save** to add to your outfit collection.

## IV. Implementation Highlights
- PhotosPicker returns a `PhotosPickerItem`; we load the image with async/await:

```swift
if let data = try? await item.loadTransferable(type: Data.self),
   let image = UIImage(data: data) { … }
```
- Imported images are stored in Documents/; `ClothingItem` tracks `isFromCameraRoll` so views know whether to load from disk or assets.

- Deleting a clothing item also deletes any outfits that reference it, keeping data consistent.

- Background loading (to keep the spinner on screen) uses:
```swift
closet = await Task.detached(priority: .userInitiated) { storage.load() }.value
```

## V. Screenshots

### Picking Outfit

https://github.com/user-attachments/assets/687248fb-c60d-41b5-9e69-cd9ee2a996b3
- Pressing "Save to Closet" saves the oufit to storage
- Success message is displayed "✅ Outfit Saved!"
- Carousels for the tops and bottoms are both swipable left and right
- Saved outfits are displayed in "Outfits" tab

  ### Duplicate Outfit

https://github.com/user-attachments/assets/19fb9e56-0dfc-469a-85b9-50abad1372b9
- Duplicate outfits are not saved
- Message is displayed "⚠️ Outfit Already Saved!"

  ### Filter Outfits

https://github.com/user-attachments/assets/2a8b5c3e-19b0-44d5-9a17-585d0bb40342

- View Outfits in "Outfits" tab
- Filter using the grid of options
  
  ### No Outfits with Selected Filter

https://github.com/user-attachments/assets/53329a48-ea70-4473-a20e-7e1fee0e61c2
- Message notifies user when there are no outfits with selected filters
  
### Delete Outfit

https://github.com/user-attachments/assets/a732347d-8598-4851-85f1-13f1e769bfff  
