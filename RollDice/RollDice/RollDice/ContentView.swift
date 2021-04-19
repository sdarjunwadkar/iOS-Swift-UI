//
//  ContentView.swift
//  RollDice
//
//  Created by Sharvil Arjunwadkar on 30/01/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        TabView {
            RollDiceView()
                .tabItem {
                    Image(systemName: "square")
                        .frame(width: 30, height: 30)
                    Text("Dice")
                }
            
            DetailsView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Details")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
