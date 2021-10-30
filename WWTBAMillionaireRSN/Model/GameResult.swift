//
//  GameResult.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 02.11.2020.
//

import Foundation

struct GameResult: Codable {
    let wonAmount: Int
    let percentageOfAnsweredQuestions: Double
    let date: Date
}
