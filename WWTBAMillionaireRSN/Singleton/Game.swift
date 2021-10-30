//
//  Game.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 29.10.2020.
//

import Foundation

class Game {
    var gameSession: GameSession?
    var wayOfAskingQuestions: WayOfAskingQuestions = .consistently
    private var percentageOfAnsweredQuestions = 0.0
    
    static let shared = Game()
    private init(){
        gameResults = gameResultsCaretaker.loadGameResults() ?? []
        userMadeQuestions = userMadeQuestionsCaretaker.loadUserMadeQuestions() ?? []
    }
    
    //MARK: - Game Results
    private(set) var gameResults: [GameResult] {
        didSet {
            gameResultsCaretaker.saveGameResults(results: gameResults)
        }
    }
    private let gameResultsCaretaker = GameResultsCaretaker()
    
    func addGameResult(result: GameResult) {
        gameResults.insert(result, at: 0)
        gameSession = GameSession()
    }
    
    func clearAllGameResults() {
        gameResults.removeAll()
    }
    
    //MARK: - User made Questions
    private(set) var userMadeQuestions: [Question] {
        didSet {
            userMadeQuestionsCaretaker.saveUserMadeQuestions(userMadeQuestions: userMadeQuestions)
        }
    }
    private let userMadeQuestionsCaretaker = UserMadeQuestionsCaretaker()
    
    func addUserMadeQuestion(userMadeQuestion: Question) {
        userMadeQuestions.append(userMadeQuestion)
    }
    
    func clearAllUserMadeQuestions() {
        userMadeQuestions.removeAll()
    }
}
