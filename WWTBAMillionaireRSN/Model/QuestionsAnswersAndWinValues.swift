//
//  QuestionsAnswersAndWinValues.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 28.10.2020.
//

import Foundation

struct Question: Codable {
    var question: String = " "
    var firstAnswer: String = " "
    var secondAnswer: String = " "
    var thirdAnswer: String = " "
    var fourthAnswer: String = " "
    var correctAnswer: String = " "
}

let winValues = ["0", "100000", "200000", "350000", "500000", "650000", "800000", "1000000", "Winner!"]

let questions: [Question] = [
    Question(question: "Where do office workers pour water into cups from?", firstAnswer: "From printer", secondAnswer: "From scanner", thirdAnswer: "From stapler", fourthAnswer: "From cooler", correctAnswer: "From cooler"),
    Question(question: "What Jack built in a poem translated from English by Marshak?", firstAnswer: "Route", secondAnswer: "Schedule", thirdAnswer: "House", fourthAnswer: "Communism", correctAnswer: "House"),
    Question(question: "What can appear on a chessboard?", firstAnswer: "Perpetual check", secondAnswer: "Perpetual checkmate", thirdAnswer: "Perpetual call", fourthAnswer: "Perpetual dispute", correctAnswer: "Perpetual check"),
    Question(question: "What is car sharing?", firstAnswer: "Second hand", secondAnswer: "Floor lamp", thirdAnswer: "Crows mating dance", fourthAnswer: "Car rent", correctAnswer: "Car rent"),
    Question(question: "Which men, according to etiquette, are not required to go to the left of the lady?", firstAnswer: "High", secondAnswer: "Military personnel", thirdAnswer: "Nonresident", fourthAnswer: "Elderly", correctAnswer: "Military personnel"),
    Question(question: "Who helped to make entries in the logbook of Thor Heyerdahl's Kon-Tiki raft?", firstAnswer: "Seagulls", secondAnswer: "Cuttlefish", thirdAnswer: "Dolphins", fourthAnswer: "Rats", correctAnswer: "Cuttlefish"),
    Question(question: "What is missing from the design of all the palaces of the Forbidden City of the Chinese emperors?", firstAnswer: "Doors", secondAnswer: "Stairs", thirdAnswer: "Windows", fourthAnswer: "Chimneys", correctAnswer: "Chimneys")
]
