//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Sharvil Arjunwadkar on 12/01/21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
