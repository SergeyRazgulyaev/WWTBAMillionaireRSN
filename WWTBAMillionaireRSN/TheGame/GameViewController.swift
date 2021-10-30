//
//  TheGameViewController.swift
//  WWTBAMillionaire
//
//  Created by Sergey Razgulyaev on 28.10.2020.
//

import UIKit

protocol TheGameDelegate: class {
    func gameOver(numberOfQuestions: Int, numberOfCorrectAnswers: Int, wonAmount: Int, percentageOfAnsweredQuestions: Double)
}

class TheGameViewController: UIViewController {
    @IBOutlet private weak var yourWinAmountLabel: UILabel!
    @IBOutlet private weak var possiblePrizeAmountLabel: UILabel!
    @IBOutlet private weak var questionTextLabel: UILabel!
    @IBOutlet private weak var pickUpYourWinningsButton: UIButton!
    @IBOutlet private weak var toContinueDescriptionLaber: UILabel!
    @IBOutlet private weak var firstAnswerButton: UIButton!
    @IBOutlet private weak var secondAnswerButton: UIButton!
    @IBOutlet private weak var thirdAnswerButton: UIButton!
    @IBOutlet private weak var fourthAnswerButton: UIButton!
    
    //MARK: - Base properties
    weak var theGameDelegate: TheGameDelegate?
    var questionNumber = 1
    var numberOfQuestions = questions.count
    var numberOfCorrectAnswers = 0
    var wonAmount = 0
    var percentageOfAnsweredQuestions = 0.0
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFirstQuestion()
    }
    
    //MARK: - Configuration Methods
    func configureFirstQuestion() {
        yourWinAmountLabel.text = "\(winValues[0])"
        possiblePrizeAmountLabel.text = "\(winValues[1])"
        questionTextLabel.text = "\(questions[0].question)"
        firstAnswerButton.setTitle("\(questions[0].firstAnswer)", for: .normal)
        secondAnswerButton.setTitle("\(questions[0].secondAnswer)", for: .normal)
        thirdAnswerButton.setTitle("\(questions[0].thirdAnswer)", for: .normal)
        fourthAnswerButton.setTitle("\(questions[0].fourthAnswer)", for: .normal)
    }
    
    func configureNextQuestion() {
        if questionNumber < (winValues.count - 1) {
            yourWinAmountLabel.text = "\(winValues[questionNumber - 1])"
            possiblePrizeAmountLabel.text = "\(winValues[questionNumber])"
            questionTextLabel.text = "\(questions[questionNumber - 1].question)"
            firstAnswerButton.setTitle("\(questions[questionNumber - 1].firstAnswer)", for: .normal)
            secondAnswerButton.setTitle("\(questions[questionNumber - 1].secondAnswer)", for: .normal)
            thirdAnswerButton.setTitle("\(questions[questionNumber - 1].thirdAnswer)", for: .normal)
            fourthAnswerButton.setTitle("\(questions[questionNumber - 1].fourthAnswer)", for: .normal)
        } else {
            clearFieldsAtTheEndOfTheGameIfWinner()
        }
    }
    
    //MARK: - Game Logic Methods
    func checkAnswer(buttonTitleText: String, correctAnswer: String) -> Bool {
        if buttonTitleText == correctAnswer {
            return true
        } else {
            return false
        }
    }
    
    func calculatePercentageOfAnsweredQuestions() {
        if numberOfCorrectAnswers == 0 {
            percentageOfAnsweredQuestions = 0.0
        } else {
            percentageOfAnsweredQuestions = Double(numberOfCorrectAnswers)/Double(numberOfQuestions) * 100
        }
    }
    
    func acceptOrRejectTheAnswer(sender: UIButton) {
        if checkAnswer(buttonTitleText: sender.titleLabel?.text ?? " ", correctAnswer: questions[questionNumber - 1].correctAnswer) {
            questionNumber += 1
            numberOfCorrectAnswers += 1
            wonAmount = Int(winValues[questionNumber - 1]) ?? -1
            configureNextQuestion()
        } else {
            print("Game over!")
            clearFieldsAtTheEndOfTheGameIfLoser()
        }
    }
    
    //MARK: - Interface change Methods
    func clearFieldsAtTheEndOfTheGameIfWinner() {
        possiblePrizeAmountLabel.textColor = .systemGreen
        yourWinAmountLabel.text = "\(winValues[questionNumber - 1])"
        possiblePrizeAmountLabel.text = "\(winValues[questionNumber])"
        questionTextLabel.text = "Congratulations!\n\nYou are a MILLIONARE!!!"
        hideAndDisableAnswersButtons()
        questionNumber = 1
    }
    
    func clearFieldsAtTheEndOfTheGameIfLoser() {
        possiblePrizeAmountLabel.textColor = .systemRed
        questionTextLabel.textColor = .systemRed
        yourWinAmountLabel.text = "\(winValues[questionNumber - 1])"
        possiblePrizeAmountLabel.text = "You lose!"
        questionTextLabel.text = "The answer is not correct!\n\n YOU LOSE!!!"
        hideAndDisableAnswersButtons()
        questionNumber = 1
    }
    
    func hideAndDisableAnswersButtons() {
        toContinueDescriptionLaber.text = ""
        firstAnswerButton.setTitle("", for: .normal)
        secondAnswerButton.setTitle("", for: .normal)
        thirdAnswerButton.setTitle("", for: .normal)
        fourthAnswerButton.setTitle("", for: .normal)
        firstAnswerButton.isEnabled = false
        secondAnswerButton.isEnabled = false
        thirdAnswerButton.isEnabled = false
        fourthAnswerButton.isEnabled = false
    }
    
    //MARK: - @IBActions
    @IBAction func firstAnswerButtonPressed(_ sender: UIButton) {
        acceptOrRejectTheAnswer(sender: sender)
    }
    
    @IBAction func secondAnswerButtonPressed(_ sender: UIButton) {
        acceptOrRejectTheAnswer(sender: sender)
    }
    
    @IBAction func thirdAnswerButtonPressed(_ sender: UIButton) {
        acceptOrRejectTheAnswer(sender: sender)
    }
    
    @IBAction func fourthAnswerButtonPressed(_ sender: UIButton) {
        acceptOrRejectTheAnswer(sender: sender)
    }
    
    @IBAction func pickUpYourWinningsButtonPressed(_ sender: UIButton) {
        calculatePercentageOfAnsweredQuestions()
        theGameDelegate?.gameOver(numberOfQuestions: numberOfQuestions, numberOfCorrectAnswers: numberOfCorrectAnswers, wonAmount: wonAmount, percentageOfAnsweredQuestions: percentageOfAnsweredQuestions)
        self.dismiss(animated: true, completion: nil)
    }
}
