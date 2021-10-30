//
//  AskingQuestionsStrategy.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 02.11.2020.
//

import Foundation

//MARK: - Protocols
protocol AskingQuestionsStrategy {
    func askingQuestions(questions: [Question]) -> [Question]
}

final class ConsistentlyAskedQuestionsStrategy: AskingQuestionsStrategy {
    func askingQuestions(questions: [Question]) -> [Question] {
        return questions
    }
}

final class ShuffledAskedQuestionsStrategy: AskingQuestionsStrategy {
    func askingQuestions(questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
