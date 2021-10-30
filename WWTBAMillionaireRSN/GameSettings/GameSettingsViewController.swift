//
//  GameSettingsViewController.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 03.11.2020.
//

import UIKit

enum WayOfAskingQuestions: String {
    case consistently = "0"
    case shuffled = "1"
}

class GameSettingsViewController: UIViewController {
    @IBOutlet weak var wayOfAskingQuestionsSegmentControl: UISegmentedControl!
    
    //MARK: - Base properties
    private var selectedWayOfAskingQuestions: WayOfAskingQuestions {
        switch self.wayOfAskingQuestionsSegmentControl.selectedSegmentIndex {
        case 0:
            return .consistently
        case 1:
            return .shuffled
        default:
            return .consistently
        }
    }
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGameSettings()
    }
    
    //MARK: - Configuration Methods
    func configureGameSettings() {
        wayOfAskingQuestionsSegmentControl.selectedSegmentIndex = Int(Game.shared.wayOfAskingQuestions.rawValue) ?? 0
    }
    
    //MARK: - @IBActions
    @IBAction func returnToTheGameMenuButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func wayOfAskingQuestionsSegmentControlSelect(_ sender: UISegmentedControl) {
        Game.shared.wayOfAskingQuestions = selectedWayOfAskingQuestions
    }
}
