//
//  HabitDetailView.swift
//  Habits
//
//  Created by Sharvil Arjunwadkar on 07/01/21.
//

import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject var habits: Habits
    var index: Int
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section(header: Text("Description")){
                        Text(habits.items[index].description)
                    }
                    Section(header: Text("Number of Times Completed")){
                        Stepper("\(habits.items[index].numberOfTimes)", onIncrement : {
                            self.habits.items[index].numberOfTimes += 1
                        }, onDecrement: {
                            self.habits.items[index].numberOfTimes -= 1
                        })
                    }
                }
            }
            .navigationBarTitle(habits.items[index].name)
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(index: 1)
    }
}
