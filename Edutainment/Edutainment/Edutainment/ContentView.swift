//
//  ContentView.swift
//  Edutainment
//
//  Created by Sharvil Arjunwadkar on 30/12/20.
//

import SwiftUI

struct ContentView: View {
    @State private var tableOf = 1
    let questionOptions = ["5", "10", "20", "All"]
    @State private var noOfQuestions = 0
    @State private var enteredAnswer = ""
    @State private var tableNum = 0
    @State private var randomNumber = 0
    @State private var question = ""
    @State private var score = 0
    @State private var count = 5
    @State private var showingAlert = false
    @State private var allQuestions = [String]()
    @State private var allAnswers = [Int]()
    @State private var randomQuestion = 0
    @State private var index = [Int]()
    var body: some View {
        NavigationView {
            VStack(spacing: 30){
                Form {
                    Section(header: Text("Select the table you want to learn")) {
                        Stepper(value: $tableOf, in: 1...12){
                            Text("\(tableOf)")
                        }
                        .onChange(of: tableOf, perform: { value in
                            allQuestions = []
                            allAnswers = []
                            for num in 1...tableOf {
                                for rnum in 1...10 {
                                    allQuestions.append("\(num) x \(rnum)")
                                    allAnswers.append(num * rnum)
                                }
                            }
                            askQuestion()
                        })
                    }
                    Section(header: Text("Select number of questions")){
                        Picker("Select number of Questions", selection: $noOfQuestions){
                            ForEach(0..<questionOptions.count){
                                Text("\(self.questionOptions[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: noOfQuestions, perform: { value in
                            count = Int(questionOptions[noOfQuestions]) ?? 0
                        })
                    }
                    Section(header: Text("Question")){
                        Text("\(question)")
                    }
                    Section(header: Text("Answer")){
                        TextField("Enter Your Answer", text: $enteredAnswer, onCommit: {
                            if count != 0 {
                                if count > 0 {
                                    self.checkAnswer(enteredAnswer)
                                    count -= 1
                                }
                                if count == 0 {
                                    showingAlert = true
                                }
                            }
                            else{
                                self.checkAnswer(enteredAnswer)
                            }
                        })
                            .keyboardType(.numberPad)
                    }
                    Section(header: Text("Current Score")){
                        Text("\(score)")
                    }
                    Button(action:{
                        playAgain()
                    }){
                        Text("Play Again")
                    }
                }
            }
            .navigationBarTitle("Edutainment")
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Game Over"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Play Again")){
                playAgain()
            })
        }
    }
    func askQuestion() {
        if allQuestions.count != 0 {
            randomQuestion = Int.random(in: 0..<allQuestions.count)
            question = allQuestions[randomQuestion]
        }
        else{
            showingAlert = true
        }
        enteredAnswer = ""
    }
    
    func checkAnswer(_ answer: String) {
        if Int(answer) == (allAnswers[randomQuestion]){
            score += 1
        }
        allQuestions.remove(at: randomQuestion)
        allAnswers.remove(at: randomQuestion)
        askQuestion()
    }
    
    func playAgain() {
        tableOf = 1
        noOfQuestions = 0
        enteredAnswer = ""
        tableNum = 0
        randomNumber = 0
        question = ""
        score = 0
        count = 0
        showingAlert = false
        allQuestions = [String]()
        allAnswers = [Int]()
        randomQuestion = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
