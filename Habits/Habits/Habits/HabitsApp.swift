//
//  HabitsApp.swift
//  Habits
//
//  Created by Sharvil Arjunwadkar on 07/01/21.
//

import SwiftUI

@main
struct HabitsApp: App {
    var habits = Habits()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(habits)
        }
    }
}
