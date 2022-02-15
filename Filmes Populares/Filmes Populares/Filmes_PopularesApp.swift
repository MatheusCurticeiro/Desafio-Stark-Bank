//
//  Filmes_PopularesApp.swift
//  Filmes Populares
//
//  Created by Matheus Curticeiro on 09/02/22.
//

import SwiftUI

@main
struct Filmes_PopularesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
