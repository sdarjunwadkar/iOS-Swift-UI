//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Sharvil Arjunwadkar on 25/12/20.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissor"]
    @State var appMove = Int.random(in: 0...2)
    @State var shouldWin = Bool.random()
    @State var score = 0
    @State var scoreTitle = ""
    @State var end = false
    @State var counter = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .red, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("Current Score: \(score)")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.yellow)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                
                HStack(spacing: 20) {
                    Text(possibleMoves[appMove])
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    
                    if shouldWin {
                        Text("Win")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                    else{
                        Text("Lose")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                }
                
                ForEach(0..<3){ number in
                    Button(action: {
                        self.choiceTapped(number)
                    }) {
                        Text(possibleMoves[number])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                    }
                }
                
                Text("\(scoreTitle)")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.yellow)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                
                
                Spacer()
            }
            
        }
        .alert(isPresented: $end){
            Alert(title: Text("Game Over"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Play Again")){
                self.reset()
            })
        }

    }
    func choiceTapped(_ number: Int) {
        if possibleMoves[appMove] == "Rock" && shouldWin && possibleMoves[number] == "Paper" {
            scoreTitle = "Correct"
            score += 1
        }
        else if possibleMoves[appMove] == "Rock" && !shouldWin && possibleMoves[number] == "Scissor" {
            scoreTitle = "Correct"
            score += 1
        }
        else if possibleMoves[appMove] == "Paper" && shouldWin && possibleMoves[number] == "Scissor" {
            scoreTitle = "Correct"
            score += 1
        }
        else if possibleMoves[appMove] == "Paper" && !shouldWin && possibleMoves[number] == "Rock" {
            scoreTitle = "Correct"
            score += 1
        }
        else if possibleMoves[appMove] == "Scissor" && shouldWin && possibleMoves[number] == "Rock" {
            scoreTitle = "Correct"
            score += 1
        }
        else if possibleMoves[appMove] == "Scissor" && !shouldWin && possibleMoves[number] == "Paper" {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong"
            if score == 0 {
                score = 0
            }
            else {
                score -= 1
            }
        }
        askQuestion()
    }
    
    func askQuestion() {
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        if counter == 10{
            end = true
        }
        counter += 1
    }
    
    func reset() {
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        end = false
        score = 0
        scoreTitle = ""
        counter = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
