//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sharvil Arjunwadkar on 24/12/20.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var animationAmount = 0.0
    @State private var enabled = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3){ number in
                    if number == correctAnswer {
                        Button(action: {
                            self.flagTapped(number)
                            withAnimation{
                                self.animationAmount += 360
                            }
                            self.enabled.toggle()
                        }){
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                                .rotation3DEffect(
                                    .degrees(animationAmount),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                    )
                        }
                    }
                    else{
                        Button(action: {
                            self.flagTapped(number)
//                            self.enabled.toggle()
                        }){
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                                .opacity(enabled ? 0.25 : 1)
                        }
                    }
                }
                Text("Current Score is \(score)")
                    .foregroundColor(.white)
                Spacer()
            }
        }
//        .alert(isPresented: $showingScore){
//            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
//                self.askQuestion()
//            })
//        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong, thats the flag of \(countries[number])"
            if score == 0 {
                score = 0
            }
            else{
                score -= 1
            }
        }
        showingScore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            askQuestion()
        })
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        enabled = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()    }
}
