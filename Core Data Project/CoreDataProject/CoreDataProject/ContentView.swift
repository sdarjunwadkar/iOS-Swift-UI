//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Sharvil Arjunwadkar on 12/01/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var whichFilter = "BEGINSWITH"
    @State private var lastNameFilter = "A"
    var body: some View {
        VStack {
            FilteredList(filter: lastNameFilter, whichPred: whichFilter)

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Contains") {
                self.lastNameFilter = "f"
                self.whichFilter = "CONTAINS"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
