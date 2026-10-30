//
//  ContentView-ViewModel.swift
//  ClayCrafts
//
//  Created by Aya on 26.08.26.
//

import Foundation
import SwiftData
import SwiftUI

//@Observable
//
//class ContentViewViewModel {
//    
//    private(set) var clayCrafts: [ClayCrafts] = []
//    var path: [ClayCrafts] = []
//    var sorting = SortDescriptor(\ClayCrafts.name)
//    var searchString: String = ""
//    var modelContext: ModelContext
//    
//    init(modelContext: ModelContext){
//        self.modelContext = modelContext
//        fetch()
//    }
//    
//    func fetch(){
//        do{
//            let descriptor = FetchDescriptor<ClayCrafts>(sortBy: [SortDescriptor(\ClayCrafts.name, order: .forward)])
//            clayCrafts = try modelContext.fetch(descriptor)
//        }catch{
//            print("Error")
//        }
//    }
//    
//    func addCraft() {
//        let clayCraft = ClayCrafts()
//        modelContext.insert(clayCraft)
//        path.append(clayCraft)
//    }
//    
//    
//    
//    
//    
//}

extension ContentView{
    @Observable
    
    class ViewModel {
        
        private(set) var clayCrafts: [ClayCrafts] = []
        var path: [ClayCrafts] = []
        var sorting = SortDescriptor(\ClayCrafts.name) {
            didSet{ fetch()}
        }
        var searchString: String = "" {
            didSet { fetch()}
        }
        var modelContext: ModelContext
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetch()
        }
                                
        
        func fetch(){
            do{
            let predicate = #Predicate<ClayCrafts> { craft in
                if searchString.isEmpty{
                    return true
                }else{
                    return craft.name.localizedStandardContains(searchString)
                }
            }
                let descriptor = FetchDescriptor<ClayCrafts>(
                    predicate: predicate,
                    sortBy: [sorting]
                )
                clayCrafts = try modelContext.fetch(descriptor)
            }catch{
                print("Error")
            }
        }
        
        func addCraft() {
                    let newCraft = ClayCrafts()
                    path.append(newCraft)
                }
        
        func deleteCrafts(_ indexSet: IndexSet) {
            for index in indexSet {
                modelContext.delete(clayCrafts[index])
            }
            fetch()
        }
        
        
        
        
        
        
    }
}
