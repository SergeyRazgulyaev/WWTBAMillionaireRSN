//
//  UserMadeQuestionsCaretaker.swift
//  WWTBAMillionaireRSN
//
//  Created by Sergey Razgulyaev on 05.11.2020.
//

import Foundation

class UserMadeQuestionsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "newQuestionsKey"
    
    func saveUserMadeQuestions(userMadeQuestions: [Question]) {
        do {
            let data = try encoder.encode(userMadeQuestions)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadUserMadeQuestions() -> [Question]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
