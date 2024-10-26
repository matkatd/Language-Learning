//
//  LanguageLearning.swift
//  Language Learning
//
//  Created by David T on 10/17/24.
//

import Foundation

struct LanguageLearning {
    // MARK: - Properties
    
    var cards: Array<Card> = []

    var topics: [Topic]
    
    var selectedTopic: Topic?
    
    var selectedOption: String?
    
    var hasBeenSubmitted: Bool = false
    
    var choseCorrectAnswer: Bool = false
    
    var score: Int {
        if let currentQuiz {
            currentQuiz.reduce(0) { $0 + $1.score }
        } else {
            0
        }
    }
    
    var currentQuiz: [QuizItem]? {
        selectedTopic?.quiz
    }
    
    init(languageLearningFactory: [Topic]) {
        self.topics = languageLearningFactory
    }
    
    // MARK: - Methods
    mutating func flipCard(card: Card) {
        if let chosenIndex = cards.firstIndex(of: card) {
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    mutating func submitAnswer(question: QuizItem) {
        if let chosenIndex = currentQuiz?.firstIndex(of: question) {
            selectedTopic?.quiz[chosenIndex].hasBeenSubmitted = true
            selectedTopic?.quiz[chosenIndex].activeQuestion = false
            if currentQuiz?[chosenIndex].selectedOption == currentQuiz?[chosenIndex].correctAnswer {
                selectedTopic?.quiz[chosenIndex].choseCorrectAnswer = true
            }
        }
    }
    
    mutating func selectAnswer(question: QuizItem, answer: String) {
        if let chosenIndex = currentQuiz?.firstIndex(of: question) {
            selectedTopic?.quiz[chosenIndex].activeQuestion = true
            selectedTopic?.quiz[chosenIndex].selectedOption = answer
        }
    }
    
    
    // MARK: - Inner structs
    
    struct Card: Identifiable, Hashable {
        fileprivate(set) var isFaceUp = false
        fileprivate(set) var word: String
        fileprivate(set) var definition: String
        fileprivate(set) var id = UUID()
        var content: String {
            isFaceUp ? definition : word
        }
    }
    
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
    
    struct QuizItem: Hashable, Identifiable {
        fileprivate(set) var id = UUID()
        var question: String
        var answers: [String]?
        var correctAnswer: String
        var questionType: QuestionType
        fileprivate(set) var bonusTimeLimit: TimeInterval = Score.maxBonusTime
        fileprivate(set) var activeQuestion: Bool = false {
            willSet (newValue) {
                if newValue {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        fileprivate(set) var selectedOption: String?
        fileprivate(set) var hasBeenSubmitted: Bool = false
        fileprivate(set) var choseCorrectAnswer: Bool = false
        fileprivate(set) var startTime: Date?
        fileprivate(set) var usedTime: TimeInterval = 0
        
        // MARK: - Computed Properties
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - usedTime)
        }
        
        var isConsumingBonusTime: Bool {
            activeQuestion && bonusTimeRemaining > 0
        }
        
        var score: Int {
            if choseCorrectAnswer {
                return Score.basePoints + bonusScore
            }
            
            return 0
        }
        
        var bonusRemainingPercent: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0)
            ? bonusTimeRemaining / bonusTimeLimit
            : 0
        }
        
        private var bonusScore: Int {
            Int(bonusTimeRemaining / 2)
        }
        
        private var faceUpTime: TimeInterval {
            if let startTime {
                usedTime + Date().timeIntervalSince(startTime)
            } else {
                usedTime
            }
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime  {
                startTime = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            usedTime = faceUpTime
            startTime = nil
        }
        
        
    }
}

// MARK: - Constants

private struct Score {
    static let basePoints = 10
    static let bonusFactor = 10.0
    static let maxBonusTime = 20.0
}

extension LanguageLearning.Topic {
    func shuffledVocabulary() -> [(String, String)] {
        return vocabulary.shuffled() // Shuffle the dictionary's key-value pairs
    }
}
