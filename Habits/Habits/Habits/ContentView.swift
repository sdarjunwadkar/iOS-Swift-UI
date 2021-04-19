//
//  ContentView.swift
//  Habits
//
//  Created by Sharvil Arjunwadkar on 07/01/21.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var numberOfTimes: Int
}

class Habits: ObservableObject{
    @Published var items = [Habit](){
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Habit].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @EnvironmentObject var habits: Habits
    @State private var showingAddHabit = false
    var body: some View {
        NavigationView {
            List{
                ForEach(habits.items.indices, id: \.self){ index in
                    NavigationLink(destination: HabitDetailView(index: index)){
                        TrialView(index: index)
//                        VStack{
//                            Text(habits.items[index].name)
//                                .font(.headline)
//                            Text(habits.items[index].description)
//                            
//                            Text("\(habits.items[index].numberOfTimes)")
//                        }
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        self.showingAddHabit = true
                                    }){
                                        Image(systemName: "plus")
                                    }
                                )
            .sheet(isPresented: $showingAddHabit) {
                AddView(habits: self.habits)
            }
        }
    }
    func removeItem(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
