//
//  OfflineInformationApp.swift
//  OfflineInformation
//
//  Created by Sharvil Arjunwadkar on 14/01/21.
//

import SwiftUI

@main
struct OfflineInformationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
