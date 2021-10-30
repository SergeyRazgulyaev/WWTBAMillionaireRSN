//
//  GameMenuViewController.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 28.10.2020.
//

import UIKit

//MARK: - ViewController
class GameMenuViewController: UIViewController {
    
    //MARK: - Base properties
    private let theGame = GameSession()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayTheGame" {
            let destinationVC = segue.destination as! TheGameViewController
            destinationVC.theGameDelegate = self
        }
    }

    //MARK: - @IBActions
    @IBAction func playTheGameButtonPressed(_ sender: UIButton) {
        Game.shared.gameSession = theGame
    }
}
//MARK: - Extension with TheGameViewControllerDelegate
extension GameMenuViewController: TheGameViewControllerDelegate {
    func endTheGame(numberOfQuestions: Int, numberOfCorrectAnswers: Int, wonAmount: Int, percentageOfAnsweredQuestions: Double, date: Date) {
        theGame.numberOfQuestions = numberOfQuestions
        theGame.numberOfCorrectAnswers = numberOfCorrectAnswers
        theGame.wonAmount = wonAmount
        theGame.percentageOfAnsweredQuestions = percentageOfAnsweredQuestions
        theGame.date = date

        let gameResultToSave = GameResult(wonAmount: theGame.wonAmount, percentageOfAnsweredQuestions: theGame.percentageOfAnsweredQuestions, date: theGame.date)
        Game.shared.addGameResult(result: gameResultToSave)
    }
}

