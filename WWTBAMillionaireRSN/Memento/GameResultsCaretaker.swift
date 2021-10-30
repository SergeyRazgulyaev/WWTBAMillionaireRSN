//
//  GameResultsCaretaker.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 01.11.2020.
//

import Foundation

class GameResultsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "resultsKey"
    
    func saveGameResults(results: [GameResult]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadGameResults() -> [GameResult]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return try decoder.decode([GameResult].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
