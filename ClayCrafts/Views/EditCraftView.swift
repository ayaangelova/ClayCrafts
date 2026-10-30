import SwiftUI
import SwiftData
import PhotosUI

struct EditCraftView: View {
    @Bindable var clayCraft: ClayCrafts
    @Binding var contentViewModel: ContentView.ViewModel
    
    @State private var viewModel = ViewModel()
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $clayCraft.name)
            TextField("Details", text: $clayCraft.details)
            Text(clayCraft.startDate, style: .date)
            DatePicker("Ending date", selection: $clayCraft.endDate)
            
            Section("Difficulty") {
                Picker("Difficulty", selection: $clayCraft.difficulty) {
                    Text("Low").tag(0)
                    Text("Medium").tag(1)
                    Text("Hard").tag(2)
                }
                .pickerStyle(.palette)
            }
            
            Section("Notes") {
                HStack {
                    TextField("Add a note", text: $viewModel.noteString)
                    Button("Add") {
                        withAnimation {
                            viewModel.addNote(to: clayCraft)
                        }
                    }
                }
                
                ForEach(clayCraft.notes) { note in
                    Text(note.name)
                }
                .onDelete { indexSet in
                    viewModel.deleteNote(at: indexSet, from: clayCraft, in: modelContext)
                }
            }
            
            Section("Photos") {
                VStack(alignment: .leading, spacing: 10) {
                    PhotosPicker(
                        selection: $viewModel.selectedItems,
                        maxSelectionCount: 5,
                        matching: .images
                    ) {
                        Label("Select photos", systemImage: "photo.on.rectangle.angled")
                    }
                    .buttonStyle(.automatic)
                    
                    if !viewModel.selectedPhotos.isEmpty {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.fixed(100))], spacing: 10) {
                                ForEach(Array(viewModel.selectedPhotos.enumerated()), id: \.offset) { index, photo in
                                    photo
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(15)
                                        .clipped()
                                }
                            }
                        }
                    } else {
                        Text("No selected item")
                    }
                }
            }
            
            Section {
                Button("Save Craft") {
                    if viewModel.saveCraft(clayCraft, in: modelContext) {
                        contentViewModel.fetch()
                        dismiss()
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .task {
            viewModel.loadInitialPhotos(from: clayCraft)
        }
        .onChange(of: viewModel.selectedItems) { _, newItems in
            Task {
                await viewModel.processSelectedPhotos(newItems, for: clayCraft)
            }
        }
    }
}
