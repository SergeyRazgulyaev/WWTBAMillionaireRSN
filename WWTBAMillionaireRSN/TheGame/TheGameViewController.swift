//
//  TheGameViewController.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 28.10.2020.
//

import UIKit

//MARK: - Protocols
protocol TheGameViewControllerDelegate: class {
    func endTheGame(numberOfQuestions: Int, numberOfCorrectAnswers: Int, wonAmount: Int, percentageOfAnsweredQuestions: Double, date: Date)
}

//MARK: - ViewController
class TheGameViewController: UIViewController {
    @IBOutlet private weak var yourWinAmountLabel: UILabel!
    @IBOutlet private weak var possiblePrizeAmountLabel: UILabel!
    @IBOutlet private weak var strategyLabel: UILabel!
    @IBOutlet private weak var questionNumberLabel: UILabel!
    @IBOutlet private weak var percentageLabel: UILabel!
    @IBOutlet private weak var questionTextLabel: UILabel!
    @IBOutlet private weak var toContinueDescriptionLaber: UILabel!
    @IBOutlet private weak var firstAnswerButton: UIButton!
    @IBOutlet private weak var secondAnswerButton: UIButton!
    @IBOutlet private weak var thirdAnswerButton: UIButton!
    @IBOutlet private weak var fourthAnswerButton: UIButton!
    @IBOutlet private weak var ifYouWantToStopTheGameLabel: UILabel!
    @IBOutlet private weak var pickUpYourWinningsButton: UIButton!
    
    //MARK: - Base properties
    weak var theGameDelegate: TheGameViewControllerDelegate?
    var wayOfAskingQuestions: WayOfAskingQuestions = Game.shared.wayOfAskingQuestions
    private var questionNumber = Observable<Int>(1)
    private var numberOfQuestions = 7
    private var numberOfCorrectAnswers = 0
    private var wonAmount = 0
    private var percentageOfAnsweredQuestions = Observable<Double>(0.0)
    private var finalPreparedQuestions: [Question] = []
    private var questionsAskedDependingOnTheStrategy: [Question] = []
    private var askingQuestionsStrategy: AskingQuestionsStrategy {
        switch self.wayOfAskingQuestions {
        case .consistently:
            strategyLabel.text = "Consistently asked"
            return ConsistentlyAskedQuestionsStrategy()
        case .shuffled:
            strategyLabel.text = "Shuffled asked"
            return ShuffledAskedQuestionsStrategy()
        }
    }
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFinalPreparedQuestions(originallyInventedQuestions: questions, userMadeQuestions: Game.shared.userMadeQuestions)
        configureQuestionsDependingOnTheStrategy(questions: finalPreparedQuestions)
        configureFirstQuestion()
        questionNumber.addObserver(self, removeIfExists: false, options: [.new, .initial]) { [weak self] (questionNumber, _) in
            self?.questionNumberLabel.text = "QUESTION \(questionNumber)"
        }
        percentageOfAnsweredQuestions.addObserver(self, removeIfExists: false, options: [.new, .initial]) { [weak self] (percentageOfAnsweredQuestions, _) in
            if percentageOfAnsweredQuestions == 0 {
                self?.percentageLabel.text = "(0% correct answers)"
            } else {
            self?.percentageLabel.text = "(" + String(format: "%.1f", percentageOfAnsweredQuestions) + "% correct answers)"
            }
        }
    }
    
    //MARK: - Configuration Methods
    func configureFinalPreparedQuestions(originallyInventedQuestions: [Question], userMadeQuestions: [Question]) {
        finalPreparedQuestions = userMadeQuestions + originallyInventedQuestions
        return
    }
    
    func configureQuestionsDependingOnTheStrategy(questions: [Question]) {
        questionsAskedDependingOnTheStrategy = self.askingQuestionsStrategy.askingQuestions(questions: questions)
    }
    
    func configureFirstQuestion() {
        calculatePercentageOfAnsweredQuestions()
        yourWinAmountLabel.text = "$ \(winValues[0])"
        possiblePrizeAmountLabel.text = "$ \(winValues[1])"
        questionTextLabel.text = "\(questionsAskedDependingOnTheStrategy[0].question)"
        firstAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[0].firstAnswer)", for: .normal)
        secondAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[0].secondAnswer)", for: .normal)
        thirdAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[0].thirdAnswer)", for: .normal)
        fourthAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[0].fourthAnswer)", for: .normal)
    }
    
    func configureNextQuestion() {
        if questionNumber.value < (winValues.count - 1) {
            calculatePercentageOfAnsweredQuestions()
            yourWinAmountLabel.text = "$ \(winValues[questionNumber.value - 1])"
            possiblePrizeAmountLabel.text = "$ \(winValues[questionNumber.value])"
            questionTextLabel.text = "\(questionsAskedDependingOnTheStrategy[questionNumber.value - 1].question)"
            firstAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[questionNumber.value - 1].firstAnswer)", for: .normal)
            secondAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[questionNumber.value - 1].secondAnswer)", for: .normal)
            thirdAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[questionNumber.value - 1].thirdAnswer)", for: .normal)
            fourthAnswerButton.setTitle("\(questionsAskedDependingOnTheStrategy[questionNumber.value - 1].fourthAnswer)", for: .normal)
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
            percentageOfAnsweredQuestions.value = 0.0
        } else {
            percentageOfAnsweredQuestions.value = Double(numberOfCorrectAnswers)/Double(numberOfQuestions) * 100
        }
    }
    
    func acceptOrRejectTheAnswer(sender: UIButton) {
        if checkAnswer(buttonTitleText: sender.titleLabel?.text ?? " ", correctAnswer: questionsAskedDependingOnTheStrategy[questionNumber.value - 1].correctAnswer) {
            questionNumber.value += 1
            numberOfCorrectAnswers += 1
            wonAmount = Int(winValues[questionNumber.value - 1]) ?? -1
            configureNextQuestion()
        } else {
            clearFieldsAtTheEndOfTheGameIfLoser()
        }
    }
    
    //MARK: - Interface change Methods
    func clearFieldsAtTheEndOfTheGameIfWinner() {
        possiblePrizeAmountLabel.textColor = .systemGreen
        yourWinAmountLabel.text = "$ \(winValues[questionNumber.value - 1])"
        possiblePrizeAmountLabel.text = "\(winValues[questionNumber.value])"
        questionTextLabel.text = "Congratulations!\n\nYou are a MILLIONARE!!!"
        hideAndDisableUnusedLabels()
    }
    
    func clearFieldsAtTheEndOfTheGameIfLoser() {
        possiblePrizeAmountLabel.textColor = .systemRed
        questionTextLabel.textColor = .systemRed
        yourWinAmountLabel.text = "$ \(winValues[questionNumber.value - 1])"
        possiblePrizeAmountLabel.text = "You lose!"
        questionTextLabel.text = "The answer is not correct!\n\n YOU LOSE!!!"
        hideAndDisableUnusedLabels()
    }
    
    func hideAndDisableUnusedLabels() {
        strategyLabel.text = " "
        questionNumberLabel.text = " "
        percentageLabel.text = " "
        toContinueDescriptionLaber.text = " "
        ifYouWantToStopTheGameLabel.text = " "
        firstAnswerButton.setTitle(" ", for: .normal)
        secondAnswerButton.setTitle(" ", for: .normal)
        thirdAnswerButton.setTitle(" ", for: .normal)
        fourthAnswerButton.setTitle(" ", for: .normal)
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
        theGameDelegate?.endTheGame(numberOfQuestions: numberOfQuestions, numberOfCorrectAnswers: numberOfCorrectAnswers, wonAmount: wonAmount, percentageOfAnsweredQuestions: percentageOfAnsweredQuestions.value, date: Date())
        self.dismiss(animated: true, completion: nil)
    }
}
