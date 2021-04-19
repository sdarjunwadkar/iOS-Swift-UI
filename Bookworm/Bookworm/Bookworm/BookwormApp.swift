//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Sharvil Arjunwadkar on 11/01/21.
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
