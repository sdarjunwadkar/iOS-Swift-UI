//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Sharvil Arjunwadkar on 30/01/21.
//

import SwiftUI

@main
struct RollDiceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
