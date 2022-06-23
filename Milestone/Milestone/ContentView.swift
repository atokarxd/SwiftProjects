//
//  ContentView.swift
//  Milestone - Education app for children
//  Task: Multiplication tables
//
//  Created by Atokarxd on 2022. 06. 22..
//

import SwiftUI

struct TitleButtonView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.bold())
            .foregroundColor(.black)
            .frame(width: 75, height: 20)
            .background(.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
extension View {
    func titleButtonStyle() -> some View {
        self.modifier(TitleButtonView())
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.bold())
            .foregroundColor(.black)
            .frame(width: 100, height: 100)
            .background(.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
extension View {
    func buttonStyle() -> some View {
        self.modifier(ButtonStyle())
    }
}

struct ContentView: View {
    
    @State private var gameRound = 1
    @State private var gamePoint = 0
    @State private var randomNumber = Int.random(in: 0..<11)
    @State private var correctAnwser = false
    @State private var randomAnswer = Bool.random()
    
    @State private var game_Over = false
    
    @State var round = 5
    @State private var rounds = [5, 10, 20]
    @State private var startTitle = "Choose a times tables"
    @State var PersonalChoose: Int = 0
    let animalsImage = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog"]
    @State var showGame = false
    
    var body: some View {
        
        ZStack {
            Image("cloudsky")
                .ignoresSafeArea()
            
            Lobby
            
            if showGame {
                GameApp
            }
        }
        .alert("Game Over", isPresented: $game_Over) {
            //Button("Go to main lobby", role: .destructive) { }
        } message: {
            Text("Yours score \(gamePoint)")
        }
        
        
    }
    var Lobby: some View {
        VStack(spacing: 10) {
            Text("Times Tables")
                .font(.largeTitle.bold())
            
            Text("Which times tables would you like to practice?")
            
            HStack(spacing: 10) {
                ForEach(0..<3) { num in
                VStack {
                    Button {
                        PersonalChoose = num + 1
                        startTitle = "Start the \(PersonalChoose) times tables"
                        print(PersonalChoose)
                    } label: {
                        Image(animalsImage[num])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    }
                    Text("\(num + 1)")
                        .titleButtonStyle()
                }
                }
            }
            HStack(spacing: 10) {
                ForEach(3..<6) { num in
                VStack {
                    Button {
                        PersonalChoose = num + 1
                        startTitle = "Start the \(PersonalChoose) times tables"
                        print(PersonalChoose)
                    } label: {
                        Image(animalsImage[num])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    }
                    Text("\(num + 1)")
                        .titleButtonStyle()
                }
                }
            }
            HStack {
                ForEach(6..<9) { num in
                VStack {
                    Button {
                        PersonalChoose = num + 1
                        startTitle = "Start the \(PersonalChoose) times tables"
                        print(PersonalChoose)
                    } label: {
                        Image(animalsImage[num])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    }
                    Text("\(num + 1)")
                        .titleButtonStyle()
                }
                }
            }
            Button {
                PersonalChoose = 10
                startTitle = "Start the \(PersonalChoose) times tables"
                print(PersonalChoose)
            } label: {
                Image(animalsImage[9])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            }
            Text("10")
                .titleButtonStyle()
            
            Text("How many questions would you like?")
            
            Picker("round", selection: $round) {
                ForEach(rounds, id: \.self) {
                    Text($0, format: .number)
                }
                
            }
            .pickerStyle(.segmented)
            .background(.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 375, height: 50)
            
            Button(startTitle) {
                showGame = true
            }
                .frame(width: 300, height: 55)
                .background(Color(red: 0 / 255, green: 204 / 255, blue: 102 / 255))
                .foregroundColor(.white)
                .font(.title2.bold())
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
        }
        .foregroundColor(.black)
        .font(.body.bold())
        .padding(5)
    }
    
    var GameApp: some View {
        ZStack {
            Image("cloudsky")
                .ignoresSafeArea()
            
            VStack{
                Text("\(gameRound) of \(round)") // round variable
                    .foregroundColor(.black)

                Image(animalsImage[PersonalChoose - 1]) // list of animals
                    .frame(width: 100, height: 200)
                Text("What is \(PersonalChoose) x \(randomNumber)?") // first number is PersonalChoose in ContentView
                    .font(.title.bold())
                    .foregroundColor(.black)
                HStack(spacing: 60) {
                    Button("\(randomAnswer ? PersonalChoose * randomNumber : Int.random(in: 0..<101))") {
                        RandomButtonAnswer(randomAnswer)
                    }
                        .buttonStyle()
                    Button("\(!randomAnswer ? PersonalChoose * randomNumber : Int.random(in: 0..<101))") {
                        RandomButtonAnswer(!randomAnswer)
                    }
                        .buttonStyle()
                }
            }
        }
    }
    
    func RestartGame() {
        if gameRound == round {
            showGame = false
            gameRound = 1
            game_Over = true
        } else {
            gameRound += 1
        }
        randomAnswer = Bool.random()
        randomNumber = Int.random(in: 0..<11)
    }
    
    func PointAdd() {
        if correctAnwser {
            gamePoint += 1
        }
    }
    
    func RandomButtonAnswer(_ correct: Bool) {
        if correct {
            correctAnwser = true
        } else {
            correctAnwser = false
        }
        PointAdd()
        RestartGame()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
