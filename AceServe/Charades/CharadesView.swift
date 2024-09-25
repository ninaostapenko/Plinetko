//
//  CharadesView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct CharadesView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var timeRemaining = 100
    
    @State var words = ["Ball", "Rackets", "Court", "Net", "Serve", "Volley", "Forehand", "Backhand", "Ace", "Deuce", "Match", "Set", "Game", "Tie-break", "Smash", "Lob", "Drop shot", "Rally", "Baseline", "Spin", "Double fault", "Fault", "Break point", "Advantage", "Love", "Slice", "Tiebreaker", "Umpire", "Referee", "Linesman", "Grip", "Overhead", "Topspin", "Underspin", "Net cord", "Foot fault", "Let", "Singles", "Doubles", "Grand Slam", "Trophy", "Winner", "Runner-up", "Champion", "Seed", "Wild card", "Qualifier", "Tournament", "Medal", "Fitness", "Endurance", "Speed", "Agility", "Strength", "Stretch", "Warm-up", "Stretching", "Reflexes", "Hydration", "Nutrition", "Injury", "Muscle", "Rest", "Recovery", "Concentration", "Focus", "Sportsmanship", "Teamwork", "Strategy", "Tactics", "Training", "Coach", "Sweat", "Racket bag", "Ball boy", "Ball girl", "Line judge", "Hawk-Eye", "Scoreboard", "Time-out", "Shirt", "Shorts", "Sneakers", "Wristband", "Headband", "Hat", "Water bottle", "Towel", "Tennis shoes", "Socks", "Grip tape", "String", "Overgrip", "Ball machine", "Practice", "Drills", "Crosscourt", "Down-the-line", "Passing shot", "Winner"]
    @State var counter = 0
    @State var isRulesShown = false
    
    @State var isStopped = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("CHARADES")
                        .foregroundStyle(Color.lightPurple)
                        .font(.system(size: 46, weight: .black))
                        .overlay {
                            Color.purpleGradient
                                .mask(
                                    Text("CHARADES")
                                        .font(Font.system(size: 46, weight: .black))
                                        .multilineTextAlignment(.center)
                                )
                            }
                    
                    Spacer()
                    
                    Button {
                        isRulesShown.toggle()
                    } label: {
                        Image(systemName: "questionmark")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                if isStopped {
                    VStack {
                        VStack {
                            Text("The time is over")
                                .font(.system(size: 52, weight: .ultraLight))
                            
                            Text("Your score is ")
                                .font(.system(size: 32, weight: .ultraLight))
                                .padding(.top)
                            
                            Text("\(counter)")
                                .foregroundStyle(.white)
                                .font(.system(size: 42, weight: .black))
                                .padding()
                                .background {
                                    Rectangle()
                                        .fill(Color.blueGradient)
                                        .cornerRadius(12)
                                        .frame(width: 100, height: 100)
                                }
                                .padding(.top)
                            
                            Button {
                                words.shuffle()
                                counter = 0
                                startTimer()
                                timeRemaining = 100
                                isStopped = false
                            } label: {
                                Text("Start again")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 22, weight: .bold))
                                    
                            }
                            .padding()
                            .background {
                                Rectangle()
                                    .fill(Color.purpleGradient)
                                    .cornerRadius(12)
                            }
                            .padding(.top, 90)
                            .padding(.bottom, 40)
                        }
                        .padding()
                        .foregroundColor(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        
                        
                        Spacer()
                    }
                } else {
                    
                    Text("Timer: \(timeRemaining)")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background {
                            Rectangle()
                                .fill(Color.purpleGradient)
                                .cornerRadius(12)
                                .frame(width: 150)
                        }
                        .padding(.bottom)
                    
                    ZStack {
                        ForEach(words, id: \.self) { word in
                            SwipeCardView(isSwipeble: true, word: word, width: displaySize().width / 1.3, height: displaySize().height / 2.5) { isKnown in
                                if isKnown {
                                    withAnimation {
                                        counter += 1
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    Text("\(counter)")
                        .foregroundStyle(.white)
                        .font(.system(size: 42, weight: .black))
                        .padding()
                        .background {
                            Rectangle()
                                .fill(Color.blueGradient)
                                .cornerRadius(12)
                                .frame(width: 100, height: 100)
                        }
                        .padding(.top)
                    
                    Spacer()
                }
                
            }
        }
        .onAppear {
            words.shuffle()
            startTimer()
        }
        .background {
            BackgroundView(image: .purple)
                .blur(radius: 3)
        }
        .sheet(isPresented: $isRulesShown) {
            ZStack {
                BackgroundView(image: .black)
                
                VStack {
                    Text("RULES")
                        .foregroundStyle(.white)
                        .font(.system(size: 42, weight: .black))
                        .padding(.top, 100)
                    
                    Text( """
Here are the rules for the game of charades:

1. Teams: Divide players into two or more teams.

2. Objective: The goal is for one team member to act out a word or phrase without speaking while their team tries to guess it.

3. Turn: On a team's turn, one player looks at a word on a card and silently acts it out while their teammates guess. No talking, sound effects, or pointing to objects in the room.

4. Correct Guess: If the team guesses the word, they swipe the card to the right and get a point. If not, no points are awarded, swipe the card to the left.

5. Winning: The team with the most points after the timer runs out wins the game.

Enjoy the game!
""")
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    Spacer()
                }
            }
        }
    }
    
    
    func startTimer() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    timer.invalidate()
                    isStopped = true
                }
            }
        }
}

#Preview {
    CharadesView()
}
