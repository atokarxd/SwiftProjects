//
//  ContentView.swift
//  RockPaperScissorsGame_SwiftUI100Days
//
//  Created by Atokarxd on 2022. 06. 13..
//

import SwiftUI

struct ButtonBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 325, height: 150)
            .font(.system(size: 75))
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct WinnerText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .foregroundColor(.white)
            .frame(width: 100, height: 50)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


struct ContentView: View {
    
    @State private var Round = 1
    @State private var Points = 0
    @State private var RPS_List = ["rock", "paper", "scissors"]
    @State private var RPS_List_Icon = ["🪨","🧻","✂️"]
    @State private var Winner = false
    @State private var AppAnswer = Int.random(in: 0..<3)
    @State private var PlayerAnswer = ""
    @State private var GameOver = false

    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            VStack {
                Text("\(Round) of 10")
                Text("You are")
                    .font(.title3.bold())
                Text(Winner ? "Win" : "Lose")
                    .modifier(WinnerText())
                Spacer()
                Text(RPS_List[AppAnswer] == RPS_List[0] ? "🪨" : RPS_List[AppAnswer] == RPS_List[1] ? "🧻" : "✂️")
                    .font(.system(size: 150))
                
                Spacer()
                Text("Your score \n\(Points)")
                    .multilineTextAlignment(.center)
                    .font(.title2.bold())
                Spacer()
                HStack(spacing: 25) {
                    /*
                    Button("🪨") {
                        PlayerAnswer = RPS_List[0]
                    }
                    Button("🧻") {
                        PlayerAnswer = RPS_List[1]
                    }
                    Button("✂️") {
                    PlayerAnswer = RPS_List[2]
                    }*/
                    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.playerChoice(number)
                            nextRound()
                        }) {
                            Text("\(RPS_List_Icon[number])")
                        }
                    
                    }
                }
                .modifier(ButtonBar())
            }
        }
        .alert(isPresented: $GameOver) {
            Alert(title: Text("Game Over!"), message: Text("Your final score was \(Points)"), dismissButton: .default(Text("Play again")) {
                resetGame()
            })
        }
    }
    
    func resetGame() {
                AppAnswer = Int.random(in: 0..<3)
                Winner = Bool.random()
                Points = 0
                Round = 1
            }
    
    func nextRound() {
        if Round == 10 {
            GameOver = true
        } else {
            Round += 1
            AppAnswer = Int.random(in: 0..<3)
            Winner = Bool.random()
        }
    }
    
    func playerChoice(_ number: Int) {
        print(number == 0 && AppAnswer == 1 ? "the player tapped rock, the player was trying to win, and the app chose paper, so don't get 1 point." : number == 0 && AppAnswer == 2 ? "the player tapped rock, the player was trying to win, and the app chose scissors, so add 1 point." : number == 0 && AppAnswer == 0 ? "the player tapped rock, the player was trying to win, and the app chose rock, so TIE." : number == 1 && AppAnswer == 0 ? "the player tapped paper, the player was trying to win, and the app chose rock, so add 1 point." : number == 1 && AppAnswer == 2 ? "the player tapped paper, the player was trying to win, and the app chose scissors, so don't get 1 point." : number == 1 && AppAnswer == 1 ? "the player tapped paper, the player was trying to win, and the app chose paper, so TIE." : number == 2 && AppAnswer == 0 ? "the player tapped scissors, the player was trying to win, and the app chose rock, so don't get 1 point." : number == 2 && AppAnswer == 1 ? "the player tapped scissors, the player was trying to win, and the app chose paper, so add 1 point." : "the player tapped scissors, the player was trying to win, and the app chose scissors, so TIE.")
        if number == 0 && AppAnswer == 2 || number == 0 && AppAnswer == 0 || number == 1 && AppAnswer == 0 || number == 1 && AppAnswer == 1 || number == 2 && AppAnswer == 1 || number == 2 && AppAnswer == 2 {
            Points += 1
            Winner = true
        } else {
            Winner = false
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
