//
//  SettingsView.swift
//  RollDice
//
//  Created by Sharvil Arjunwadkar on 30/01/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var numberofDices: Int
    @Binding var sidesofDice: Int
    let diceSides: [Int]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select number of dices.")){
                    Stepper("Number of Dices: \(numberofDices)", value: $numberofDices, in: 1...4)
                }
                Section(header: Text("Select number of sides")){
                    Picker("Number of sides", selection: $sidesofDice){
                        ForEach(0..<diceSides.count, id: \.self){
                            Text("\(diceSides[$0])")
                        }
                    }
                }
                Section {
                    Button("Done"){
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
