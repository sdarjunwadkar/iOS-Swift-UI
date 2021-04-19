//
//  AddView.swift
//  Habits
//
//  Created by Sharvil Arjunwadkar on 07/01/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    @State private var numberOfTimes = 0
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter your habit", text: $name)
                
                TextField("Enter Description", text: $description)
                
            }
            .navigationBarTitle("Add New Habit")
            .navigationBarItems(trailing:
                Button("Add"){
                    let item = Habit(name: name, description: description, numberOfTimes: numberOfTimes)
                    habits.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
