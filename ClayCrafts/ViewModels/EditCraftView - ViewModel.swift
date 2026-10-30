import Foundation
import SwiftData
import SwiftUI
import PhotosUI

extension EditCraftView {
    @Observable
    class ViewModel {
        var noteString: String = ""
        var selectedItems: [PhotosPickerItem] = []
        var selectedPhotos: [Image] = []
      
        func loadInitialPhotos(from craft: ClayCrafts) {
            selectedPhotos = craft.photoData.compactMap { data in
                if let uiImage = UIImage(data: data) {
                    return Image(uiImage: uiImage)
                }
                return nil
            }
        }
        
        @MainActor
        func processSelectedPhotos(_ items: [PhotosPickerItem], for craft: ClayCrafts) async {
            var newPhotoData: [Data] = []
            var newImages: [Image] = []
            
            for item in items {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    newPhotoData.append(data)
                    if let uiImage = UIImage(data: data) {
                        newImages.append(Image(uiImage: uiImage))
                    }
                }
            }
            
            self.selectedPhotos = newImages
            craft.photoData = newPhotoData
        }
        
        
        func addNote(to craft: ClayCrafts) {
            let trimmed = noteString.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { return }
            
            
            let note = Note(name: trimmed, craft: craft)
            craft.notes.append(note)
            noteString = ""
        }
        
        func deleteNote(at indexSet: IndexSet, from craft: ClayCrafts, in context: ModelContext) {
            for index in indexSet {
                context.delete(craft.notes[index])
                
            }
        }
        
    
        func saveCraft(_ craft: ClayCrafts, in context: ModelContext) -> Bool {
            guard !craft.name.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
            context.insert(craft)
            
            do{
                try context.save()
                return true
            }catch{
                print("Error \(error.localizedDescription)")
                return false
            }
            
        }
    }
}
