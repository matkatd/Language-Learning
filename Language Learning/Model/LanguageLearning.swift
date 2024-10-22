//
//  LanguageLearning.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import Foundation

struct LanguageLearning {
    var topics: [Topic]
    
    struct Topic: Hashable {
        var title: String
        var lessonText: String
        var vocabulary: VocabDictionary
        var quiz: [QuizItem]
    }
    
    enum QuestionType {
        case trueFalse
        case multipleChoice
        case fillInTheBlank
    }
    
    struct QuizItem: Hashable {
        var question: String
        var answers: [String]?
        var correctAnswer: String
        var questionType: QuestionType
    }
}

extension LanguageLearning.Topic {
    func shuffledVocabulary() -> [(String, String)] {
        return vocabulary.shuffled() // Shuffle the dictionary's key-value pairs
    }
}
