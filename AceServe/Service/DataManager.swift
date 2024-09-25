//
//  DataManager.swift
//  AceServe
//
//  Created by D K on 23.09.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


class DataManager {
    static let shared = DataManager()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private init(){}
    
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data("http://plintennis.com/?sub12\(string)".utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func createCode() -> String {
        let randomNumber = Int.random(in: 0...999_999)
        let formattedNumber = String(format: "%06d", randomNumber)
        let formattedString = formattedNumber.prefix(3) + " " + formattedNumber.suffix(3)
        return String(formattedString)
    }
    
    func createInitialData() {
        
        if !UserDefaults.standard.bool(forKey: "init") {
            UserDefaults.standard.setValue(true, forKey: "init")
            
            UserDefaults.standard.setValue(createCode(), forKey: "code")
        }
    }
    
    
     var questions: [Question] = [
        Question(question: "Who has won the most Grand Slam titles in men's singles?",
                 answers: ["Rafael Nadal", "Roger Federer", "Novak Djokovic", "Pete Sampras"],
                 correctAnswer: 2),
                 
        Question(question: "What is the term for a score of zero in tennis?",
                 answers: ["Ace", "Love", "Deuce", "Fault"],
                 correctAnswer: 1),
                 
        Question(question: "How many sets are played in a men's Grand Slam final?",
                 answers: ["3", "5", "2", "4"],
                 correctAnswer: 1),
                 
        Question(question: "Who was the first man to win all four Grand Slam tournaments in a single year?",
                 answers: ["Rod Laver", "Bjorn Borg", "Andre Agassi", "John McEnroe"],
                 correctAnswer: 0),
                 
        Question(question: "What surface is the French Open played on?",
                 answers: ["Grass", "Hard", "Clay", "Synthetic"],
                 correctAnswer: 2),
                 
        Question(question: "Which Grand Slam is played on grass?",
                 answers: ["Australian Open", "French Open", "US Open", "Wimbledon"],
                 correctAnswer: 3),
                 
        Question(question: "What is the maximum score in a tiebreaker?",
                 answers: ["6", "7", "10", "12"],
                 correctAnswer: 1),
                 
        Question(question: "Who has the fastest recorded serve in tennis history?",
                 answers: ["Andy Roddick", "John Isner", "Ivo Karlovic", "Sam Groth"],
                 correctAnswer: 3),
                 
        Question(question: "Which female player has the most Grand Slam singles titles?",
                 answers: ["Serena Williams", "Steffi Graf", "Margaret Court", "Martina Navratilova"],
                 correctAnswer: 2),
                 
        Question(question: "What is the nickname for the US Open night sessions?",
                 answers: ["Super Saturday", "Night Fever", "Prime Time", "The Big Show"],
                 correctAnswer: 2),
                 
        Question(question: "What year did Roger Federer win his first Grand Slam?",
                 answers: ["2000", "2003", "2004", "2001"],
                 correctAnswer: 1),
                 
        Question(question: "Who was the youngest player to win a Grand Slam title?",
                 answers: ["Boris Becker", "Rafael Nadal", "Martina Hingis", "Steffi Graf"],
                 correctAnswer: 2),
                 
        Question(question: "What is the length of a tennis court?",
                 answers: ["23.77 meters", "21 meters", "25 meters", "24 meters"],
                 correctAnswer: 0),
                 
        Question(question: "Who holds the record for the most consecutive weeks at World No. 1?",
                 answers: ["Pete Sampras", "Novak Djokovic", "Roger Federer", "Jimmy Connors"],
                 correctAnswer: 2),
                 
        Question(question: "Which tournament is the oldest tennis tournament in the world?",
                 answers: ["US Open", "Australian Open", "Wimbledon", "French Open"],
                 correctAnswer: 2),
                 
        Question(question: "Who is the only player to complete a Golden Slam?",
                 answers: ["Serena Williams", "Steffi Graf", "Novak Djokovic", "Roger Federer"],
                 correctAnswer: 1),
                 
        Question(question: "How many Grand Slam tournaments are there in a year?",
                 answers: ["2", "3", "4", "5"],
                 correctAnswer: 2),
                 
        Question(question: "What is it called when a player wins a point right after the serve?",
                 answers: ["Ace", "Fault", "Love", "Smash"],
                 correctAnswer: 0),
                 
        Question(question: "What is the height of the tennis net at the center?",
                 answers: ["1.06 meters", "0.91 meters", "1.14 meters", "1.22 meters"],
                 correctAnswer: 1),
                 
        Question(question: "Who was the first player to win 20 Grand Slam singles titles?",
                 answers: ["Roger Federer", "Rafael Nadal", "Novak Djokovic", "Bjorn Borg"],
                 correctAnswer: 0),
                 
        Question(question: "Which tournament is known as the 'Happy Slam'?",
                 answers: ["Australian Open", "French Open", "Wimbledon", "US Open"],
                 correctAnswer: 0),
                 
        Question(question: "How long is the longest tennis match ever played?",
                 answers: ["5 hours", "8 hours", "11 hours", "9 hours"],
                 correctAnswer: 2),
                 
        Question(question: "Which tennis player was nicknamed 'The King of Clay'?",
                 answers: ["Rafael Nadal", "Bjorn Borg", "Novak Djokovic", "Roger Federer"],
                 correctAnswer: 0),
                 
        Question(question: "How many games must a player win to win a set in tennis?",
                 answers: ["4", "6", "5", "7"],
                 correctAnswer: 1),
                 
        Question(question: "Which of these is NOT a type of tennis court surface?",
                 answers: ["Grass", "Sand", "Hard", "Clay"],
                 correctAnswer: 1),
                 
        Question(question: "What year did tennis return to the Olympics?",
                 answers: ["1984", "1988", "1992", "1976"],
                 correctAnswer: 1),
                 
        Question(question: "What is the term for when both players have 40 points?",
                 answers: ["Advantage", "Break point", "Deuce", "Match point"],
                 correctAnswer: 2),
                 
        Question(question: "What is a 'let' in tennis?",
                 answers: ["A serve that hits the net and lands in", "A serve that is out of bounds",
                          "A shot that goes over the net and then back", "A point that is replayed"],
                 correctAnswer: 0),
                 
        Question(question: "Who won the women's singles at Wimbledon in 2021?",
                 answers: ["Ashleigh Barty", "Serena Williams", "Simona Halep", "Naomi Osaka"],
                 correctAnswer: 0),
                 
        Question(question: "What country hosts the French Open?",
                 answers: ["Spain", "France", "Italy", "Belgium"],
                 correctAnswer: 1),
                 
        Question(question: "Which country has won the most Davis Cup titles?",
                 answers: ["Australia", "USA", "Spain", "France"],
                 correctAnswer: 1),
                 
        Question(question: "What is a 'bagel' in tennis slang?",
                 answers: ["A match with no sets won", "A 6-0 set", "A serve-and-volley play",
                          "A forehand winner"],
                 correctAnswer: 1),
                 
        Question(question: "How many points is an 'advantage' worth?",
                 answers: ["1", "2", "3", "None"],
                 correctAnswer: 0),
                 
        Question(question: "What is the name of the trophy awarded to the men's singles champion at Wimbledon?",
                 answers: ["Norman Brookes Challenge Cup", "Musketeers' Trophy", "Venus Rosewater Dish",
                          "Gentlemen's Singles Trophy"],
                 correctAnswer: 3),
                 
        Question(question: "Which male tennis player was nicknamed 'The Rocket'?",
                 answers: ["Andre Agassi", "Rod Laver", "Bjorn Borg", "Pete Sampras"],
                 correctAnswer: 1),
                 
        Question(question: "What is the fastest surface in tennis?",
                 answers: ["Grass", "Clay", "Hard", "Synthetic"],
                 correctAnswer: 0),
                 
        Question(question: "What is the name of the annual international team competition in tennis?",
                 answers: ["Laver Cup", "Davis Cup", "Hopman Cup", "Fed Cup"],
                 correctAnswer: 1),
                 
        Question(question: "Who won the first-ever ATP Finals?",
                 answers: ["Bjorn Borg", "Ivan Lendl", "Stan Smith", "Pete Sampras"],
                 correctAnswer: 2),
                 
        Question(question: "Who is the oldest player to win a Grand Slam singles title?",
                 answers: ["Serena Williams", "Roger Federer", "Ken Rosewall", "Andre Agassi"],
                 correctAnswer: 2),
                 
        Question(question: "What is a 'drop shot' in tennis?",
                 answers: ["A serve with heavy spin", "A shot hit softly just over the net",
                          "A high lob shot", "A shot hit with great power"],
                 correctAnswer: 1),
                 
        Question(question: "How many Grand Slam titles has Serena Williams won?",
                 answers: ["22", "23", "24", "25"],
                 correctAnswer: 1),
                 
        Question(question: "Which player is known for his rivalry with Rafael Nadal?",
                 answers: ["Roger Federer", "Andy Murray", "Novak Djokovic", "Pete Sampras"],
                 correctAnswer: 0)
        
        ]
}
