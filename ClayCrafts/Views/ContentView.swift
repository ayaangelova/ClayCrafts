//
//  ContentView.swift
//  ClayCrafts
//
//  Created by Aya on 20.08.26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var viewModel: ViewModel
    
    init(modelContext: ModelContext) {
            let viewModel = ViewModel(modelContext: modelContext)
            _viewModel = State(initialValue: viewModel)
        }
    
    var body: some View {
        NavigationStack(path: $viewModel.path){
            ListView(viewModel: $viewModel, onDeleteAction: viewModel.deleteCrafts(_:))
                .searchable(text: $viewModel.searchString)
                .navigationTitle("My clay crafts")
                .toolbar{
                    Button("Add a craft",systemImage: "plus", action: viewModel.addCraft )
                
                    Menu("Sorting", systemImage: "arrow.up.arrow.down"){
                        Picker("Sorting", selection: $viewModel.sorting){
                            Text("By name").tag(SortDescriptor(\ClayCrafts.name))
                            Text("By difficulty").tag(SortDescriptor(\ClayCrafts.difficulty, order: .reverse))
                            Text("By end date").tag(SortDescriptor(\ClayCrafts.endDate, order: .forward))
                            
                        }.pickerStyle(.inline)
                    }
                }
                .navigationDestination(for: ClayCrafts.self) { note in
                    EditCraftView(clayCraft: note, contentViewModel: $viewModel)
                }
                .onAppear{
                    print("onAppear of sorting view")
                    viewModel.fetch()
                }
            
            

        }
        .onAppear{
            print("onAppear of navigation stack view") //only one rerendering => the onAppear has to be with the list, not actually working just for example
        }
        
    }
    
    
}



