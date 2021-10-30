//
//  ResultsTableViewCell.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 31.10.2020.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var dateValueLabel: UILabel!
    @IBOutlet private weak var wonAmountLabel: UILabel!
    @IBOutlet private weak var wonAmountValueLabel: UILabel!
    @IBOutlet private weak var percentageOfAnsweredQuestionsLabel: UILabel!
    @IBOutlet private weak var percentageOfAnsweredQuestionsValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK: - Access Methods
    func configureDateLabel(dateLabelText: String) {
        dateLabel.text = dateLabelText
    }
    
    func configureDateValueLabel(dateValue: String) {
        dateValueLabel.text = dateValue
    }
    
    func configureWonAmountLabel(wonAmountLabelText: String) {
        wonAmountLabel.text = wonAmountLabelText
    }
    
    func configureWonAmountValueLabel(wonAmountValue: String) {
        wonAmountValueLabel.text = wonAmountValue
    }
    
    func configurePercentageOfAnsweredQuestionsLabel(percentageOfAnsweredQuestionsLabelText: String) {
        percentageOfAnsweredQuestionsLabel.text = percentageOfAnsweredQuestionsLabelText
    }
    
    func configurePercentageOfAnsweredQuestionsValueLabel(percentageOfAnsweredQuestionsValue: String) {
        percentageOfAnsweredQuestionsValueLabel.text = percentageOfAnsweredQuestionsValue
    }
    
    
}
