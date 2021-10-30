//
//  ResultsViewController.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 30.10.2020.
//

import UIKit

//MARK: - ViewController
class ResultsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Cell properties
    private let resultsCellIdentifier = "ResultsCellIdentifier"
    private let resultsCellName = "ResultsTableViewCell"
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Configuration Methods
    func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: resultsCellName, bundle: nil), forCellReuseIdentifier: resultsCellIdentifier)
    }
    
    //MARK: - @IBActions
    @IBAction func returnToTheGameMenuButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAllResultsButtonPressed(_ sender: UIButton) {
        Game.shared.clearAllGameResults()
        tableView.reloadData()
    }
}

//MARK: - TableViewDataSource
extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Game.shared.gameResults.count == 0 {
            return 1
        } else {
            return Game.shared.gameResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureCell(indexPath: indexPath)
    }
    
    func configureCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resultsCellIdentifier, for: indexPath) as? ResultsTableViewCell else {
            print("Error with News Cell")
            return UITableViewCell()
        }
        if Game.shared.gameResults.count == 0 {
            cell.configureDateLabel(dateLabelText: "No saved Game Results")
            cell.configureWonAmountLabel(wonAmountLabelText: "")
            cell.configurePercentageOfAnsweredQuestionsLabel(percentageOfAnsweredQuestionsLabelText: "")
            cell.configureDateValueLabel(dateValue: "")
            cell.configureWonAmountValueLabel(wonAmountValue: "")
            cell.configurePercentageOfAnsweredQuestionsValueLabel(percentageOfAnsweredQuestionsValue: "")
        } else {
            let gameResult = Game.shared.gameResults[indexPath.row]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            cell.configureDateValueLabel(dateValue: dateFormatter.string(from: gameResult.date))
            cell.configureWonAmountValueLabel(wonAmountValue: "$ " + String(gameResult.wonAmount))
            cell.configurePercentageOfAnsweredQuestionsValueLabel(percentageOfAnsweredQuestionsValue: String(format: "%.1f", gameResult.percentageOfAnsweredQuestions) + " %")
        }
        return cell
    }
}
