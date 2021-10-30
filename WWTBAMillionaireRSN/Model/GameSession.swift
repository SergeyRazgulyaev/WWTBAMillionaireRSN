//
//  GameSession.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 29.10.2020.
//

import Foundation

class GameSession: Codable {    
    var numberOfQuestions: Int
    var numberOfCorrectAnswers: Int
    var wonAmount: Int
    var percentageOfAnsweredQuestions: Double
    var date: Date
    
    init(numberOfQuestions: Int, numberOfCorrectAnswers: Int, wonAmount: Int, percentageOfAnsweredQuestions: Double, date: Date) {
        self.numberOfQuestions = numberOfQuestions
        self.numberOfCorrectAnswers = numberOfCorrectAnswers
        self.wonAmount = wonAmount
        self.percentageOfAnsweredQuestions = percentageOfAnsweredQuestions
        self.date = date
    }
    
    convenience init() {
        self.init(numberOfQuestions: 0, numberOfCorrectAnswers: 0, wonAmount: 0, percentageOfAnsweredQuestions: 0, date: Date())
    }
}
