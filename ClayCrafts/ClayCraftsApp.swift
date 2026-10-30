//
//  ClayCraftsApp.swift
//  ClayCrafts
//
//  Created by Aya on 20.08.26.
//

import SwiftUI
import SwiftData
@main
struct ClayCraftsApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(for: ClayCrafts.self)
    }
    init() {
        do {
            container = try ModelContainer(for: ClayCrafts.self)
        } catch {
            fatalError("Failed to create ModelContainer for ClayCrafts: \(error)")
        }
    }
}
