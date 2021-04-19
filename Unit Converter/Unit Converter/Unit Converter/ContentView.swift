//
//  ContentView.swift
//  Unit Converter
//
//  Created by Sharvil Arjunwadkar on 23/12/20.
//

import SwiftUI

struct ContentView: View {
    @State private var enteredValue = ""
    @State private var fromUnit = 1
    @State private var toUnit = 2
    let Units = ["m", "km", "feet", "yard", "miles"]
    var convertedValue: Double {
        let givenValue = Double(enteredValue) ?? 0
        var value: Double = 0.0
        
        if Units[fromUnit] == "m" && Units[toUnit] == "m" {
            value = givenValue
        }
        else if Units[fromUnit] == "m" && Units[toUnit] == "km" {
            value = givenValue / 1000
        }
        else if Units[fromUnit] == "m" && Units[toUnit] == "feet" {
            value = givenValue * 3.281
        }
        else if Units[fromUnit] == "m" && Units[toUnit] == "yard" {
            value = givenValue * 1.094
        }
        else if Units[fromUnit] == "m" && Units[toUnit] == "miles" {
            value = givenValue / 1609
        }
        else if Units[fromUnit] == "km" && Units[toUnit] == "km" {
            value = givenValue
        }
        else if Units[fromUnit] == "km" && Units[toUnit] == "km" {
            value = givenValue
        }
        else if Units[fromUnit] == "km" && Units[toUnit] == "m" {
            value = givenValue * 1000
        }
        else if Units[fromUnit] == "km" && Units[toUnit] == "feet" {
            value = givenValue * 3281
        }
        else if Units[fromUnit] == "km" && Units[toUnit] == "yard" {
            value = givenValue * 1094
        }
        else if Units[fromUnit] == "km" && Units[toUnit] == "miles" {
            value = givenValue / 1.609
        }
        else if Units[fromUnit] == "feet" && Units[toUnit] == "m" {
            value = givenValue / 3.281
        }
        else if Units[fromUnit] == "feet" && Units[toUnit] == "km" {
            value = givenValue / 3281
        }
        else if Units[fromUnit] == "feet" && Units[toUnit] == "feet" {
            value = givenValue
        }
        else if Units[fromUnit] == "feet" && Units[toUnit] == "yard" {
            value = givenValue / 3
        }
        else if Units[fromUnit] == "feet" && Units[toUnit] == "miles" {
            value = givenValue / 5280
        }
        else if Units[fromUnit] == "yard" && Units[toUnit] == "m" {
            value = givenValue / 1.094
        }
        else if Units[fromUnit] == "yard" && Units[toUnit] == "km" {
            value = givenValue / 1094
        }
        else if Units[fromUnit] == "yard" && Units[toUnit] == "feet" {
            value = givenValue * 3
        }
        else if Units[fromUnit] == "yard" && Units[toUnit] == "yard" {
            value = givenValue
        }
        else if Units[fromUnit] == "yard" && Units[toUnit] == "miles" {
            value = givenValue / 1760
        }
        else if Units[fromUnit] == "miles" && Units[toUnit] == "m" {
            value = givenValue * 1609
        }
        else if Units[fromUnit] == "miles" && Units[toUnit] == "km" {
            value = givenValue * 1.609
        }
        else if Units[fromUnit] == "miles" && Units[toUnit] == "feet" {
            value = givenValue * 5280
        }
        else if Units[fromUnit] == "miles" && Units[toUnit] == "yard" {
            value = givenValue * 1760
        }
        else {
            value = givenValue
        }
//        switch Units[fromUnit] {
//        case "m":
//            value = givenValue
//        case "km":
//            value = givenValue * 1000
//        }
        return value
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter a value", text: $enteredValue)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("From Unit")) {
                    Picker("From Unit", selection: $fromUnit) {
                        ForEach(0..<Units.count) {
                            Text("\(self.Units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("To Unit")) {
                    Picker("To Unit", selection: $toUnit) {
                        ForEach(0..<Units.count) {
                            Text("\(self.Units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(convertedValue, specifier: "%.3f")")
                }
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
