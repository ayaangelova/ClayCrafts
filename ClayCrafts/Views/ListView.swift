//
//  SortingView.swift
//  ClayCrafts
//
//  Created by Aya on 20.08.26.
//

import SwiftUI
import SwiftData

//struct SortingView: View {
//    
////    @Bindable var viewModel: ContentView.ViewModel
//    @Binding var viewModel: ContentView.ContentViewViewModel
//    
//    var body: some View {
//        List{
//            ForEach(viewModel.clayCrafts) { clayCraft in
//                NavigationLink(value: clayCraft){
//                    VStack(alignment: .leading){
//                        Text(clayCraft.name)
//                            .font(.headline)
//                        Text(clayCraft.details)
//                            .font(.subheadline)
//                    }
//                }
//            }.onDelete(perform: deleteCraft)
//        }
//        
//        
//    }
//
//    func deleteCraft(_ indexSet: IndexSet) {
//        for index in indexSet {
//            viewModel.modelContext.delete(viewModel.clayCrafts[index])
//        }
//        viewModel.fetch()
//    }
//}
//    init(sort: SortDescriptor<ClayCrafts>, search: String){
//        _clayCrafts = Query(filter: #Predicate{
//            if search.isEmpty {
//                true
//            }else{
//                $0.name.localizedStandardContains(search)
//            }
//        }
//                            ,sort: [sort])
//    }


struct ListView: View {
    
//    @Bindable var viewModel: ContentView.ViewModel
    @Binding var viewModel: ContentView.ViewModel
    
    let onDeleteAction: (_ indexSet: IndexSet) -> Void
    
    
    var body: some View {
        List{
            ForEach(viewModel.clayCrafts) { clayCraft in
                NavigationLink(value: clayCraft){
                   
                        VStack(alignment: .leading){
                            
                            Text(clayCraft.name)
                                .font(.headline)
                            Text(clayCraft.details)
                                .font(.subheadline)
                            
                        }
                        
                    }
                
                }.onDelete(perform: onDeleteAction)
            }
        }
    //init(sort: SortDescriptor<ClayCrafts>, search: String){
    //        _clayCrafts = Query(filter: #Predicate{
    //            if search.isEmpty {
    //                true
    //            }else{
    //                $0.name.localizedStandardContains(search)
    //            }
    //        }
    //                            ,sort: [sort])
        
        
    }

//    func deleteCraft(_ indexSet: IndexSet) {
//        onDeleteAction()
//    }

