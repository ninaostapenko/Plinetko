//
//  QuizView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct QuizView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showNextButton = false
    @State private var score = 0
    
    @State private var questions: [Question] = [
        Question(question: "What is the capital of France?", answers: ["Berlin", "Madrid", "Paris", "Rome"], correctAnswer: 2),
        Question(question: "What is 2 + 2?", answers: ["3", "4", "5", "6"], correctAnswer: 1)
    ]
    
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
                    
                    Text("QUIZ")
                        .foregroundStyle(Color.lightPurple)
                        .font(.system(size: 46, weight: .black))
                        .overlay {
                            Color.purpleGradient
                                .mask(
                                    Text("QUIZ")
                                        .font(Font.system(size: 46, weight: .black))
                                        .multilineTextAlignment(.center)
                                )
                            }
                        .padding(.trailing, 22)
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 20) {
                        Text("\(score)")
                            .foregroundStyle(.white)
                            .font(.system(size: 38, weight: .black))
                            .background {
                                Rectangle()
                                    .fill(Color.blueGradient)
                                    .cornerRadius(12)
                                    .frame(width: 80, height: 80)
                            }
                            .padding(.top, 20)
                        
                        Text(questions[currentQuestionIndex].question)
                            .frame(width: displaySize().width - 70, height: 160)
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                            .background {
                                Rectangle()
                                    .fill(Color.blueGradient)
                                    .frame(width: displaySize().width - 50, height: 120)
                                    .cornerRadius(12)
                            }
                        
                        VStack {
                            ForEach(0..<questions[currentQuestionIndex].answers.count, id: \.self) { index in
                                Button(action: {
                                    if index != questions.count - 1 {
                                        selectAnswer(index)
                                    } else {
                                        dismiss()
                                    }
                                }) {
                                    Text(questions[currentQuestionIndex].answers[index])
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(buttonColor(for: index))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                                .disabled(selectedAnswer != nil)
                            }
                        }
                        .padding(.vertical, -20)
                        
                        Button(action: nextQuestion) {
                            Text("Continue")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .frame(height: 60)
                        .disabled(!showNextButton)
                        
                        Spacer()
                        
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            questions = DataManager.shared.questions
            questions.shuffle()
        }
        .background {
            BackgroundView(image: .purple)
                .blur(radius: 3)
        }
    }
    
    private func selectAnswer(_ index: Int) {
        selectedAnswer = index
        if index == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        showNextButton = true
    }
    
    private func buttonColor(for index: Int) -> Color {
        if let selected = selectedAnswer {
            if selected == index {
                return index == questions[currentQuestionIndex].correctAnswer ? .green : .red
            }
        }
        return .gray
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showNextButton = false
        }
    }
}
    


#Preview {
    QuizView()
}
