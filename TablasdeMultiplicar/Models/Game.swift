//
//  Game.swift
//  TablasdeMultiplicar
//
//  Created by Sergio Ocón Cárdenas on 10/11/21.
//

import Foundation



struct MultiplicationQuestion {
    let answer: Int
    let question: String
}

extension MultiplicationQuestion {
    init(_ i: Int, _ j: Int) {
        self.init(answer: i*j, question: "\(i) * \(j)")
    }
}

class Questionnaire: ObservableObject{
    var remaining: Int { questions.count }
    var questions: [MultiplicationQuestion] = []
    @Published var correct: Int = 0
    @Published var incorrect: Int = 0
    
    init(_ questions: [MultiplicationQuestion] = [], correct: Int = 0, incorrect: Int = 0)
    {
        self.questions = questions
        self.correct = correct
        self.incorrect = incorrect
    }
    
    var currentQuestion: MultiplicationQuestion? {
        questions.first
    }
    
    func answerQuestion(_ response: Int) {
        if let q = currentQuestion {
            if q.answer == response {
                correct += 1
            }
            else {
                incorrect += 1
            }
            questions.removeFirst()
            return
                
        }
        else{
            return
        }
    }
}


extension Questionnaire: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Questionnaire: Equatable {
    static func == (lhs: Questionnaire, rhs: Questionnaire) -> Bool {
        lhs === rhs
    }
    

}

