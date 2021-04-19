//
//  RollDiceView.swift
//  RollDice
//
//  Created by Sharvil Arjunwadkar on 30/01/21.
//

import SwiftUI

struct RollDiceView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingSettings = false
    @State private var numberofDices = 1
    @State private var sidesofDice = 0
    @State private var randomNumberArray = [Int]()
    @State private var feedback = UINotificationFeedbackGenerator()
    let diceSides = [4, 6, 8, 10, 12, 20, 100]
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.gray, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    if !randomNumberArray.isEmpty {
                        ForEach(randomNumberArray, id: \.self){ index in
                            Text("\(index)")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color.red)
                                .padding()
                                .frame(width: 100, height: 100)
                                .background(Color.blue.opacity(0.7))
                                .shadow(radius: 10)
                                .padding()
                        }
                    }
                    else {
                        Text("Please apply settings and click on Roll")
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(Color.red)
                    }
                }
                Spacer()
                    
                HStack {
                    Button(action: {
                        self.showingSettings = true
                    }){
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                            .padding()
                    }
                    Spacer()
                        .frame(width: 200)
                    Button(action: {
                        self.feedback.notificationOccurred(.warning)
                        self.randomNumberArray = randomGenerator(numberofDices)
                        // save to model
                        var total: Int {
                            var sum = 0
                            for number in randomNumberArray {
                                sum += number
                            }
                            return sum
                        }
                        
                        let newDice = Dice(context: self.moc)
                        newDice.numberOfDice = Int16(self.numberofDices)
                        newDice.numberOfSides = Int16(self.diceSides[sidesofDice])
                        newDice.diceTotal = Int16(total)
                        
                        try? self.moc.save()
                    }){
                        Text("Roll")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
            }
        }
        .sheet(isPresented: $showingSettings){
            SettingsView(numberofDices: $numberofDices, sidesofDice: $sidesofDice, diceSides: diceSides)
        }
    }
    
    func randomGenerator(_ numberofDices: Int) -> [Int] {
        var arr: [Int] = []
        for _ in 0..<numberofDices {
            let randomNumber = Int.random(in: 1...diceSides[sidesofDice])
            arr.append(randomNumber)
        }
        return arr
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
